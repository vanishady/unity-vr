import numpy as np
import pandas as pd
from collections import Counter
import time
import argparse
from pythonosc import udp_client
from pythonosc import dispatcher, osc_server
import os
import pretty_midi
import threading


dirname = os.path.dirname(__file__) #local folder 

sample_base = dirname+'/data/_light_theme.mid'
sample_horror = dirname+'/data/_L_theme.mid'


def midi_sequences(midi_file: str):
    """Returns correct notes sequence of chosen midi samples"""

    pm = pretty_midi.PrettyMIDI(midi_file)
    midi_sequence = []

    instrument = pm.instruments[0]
    for note in (instrument.notes):
        note_name = pretty_midi.note_number_to_name(note.pitch)
        midi_sequence.append(note_name)
            
    return midi_sequence


base_seq = midi_sequences(sample_base)
horror_seq = midi_sequences(sample_horror)
  

# Generate Bigrams 
n = 2
base_ngrams = [base_seq[i:i + n] for i in range(len(base_seq) - n + 1)]
horror_ngrams = [horror_seq[i:i + n] for i in range(len(horror_seq) - n + 1)]

# Count transitions & generate transition matrix
def generate_transition_matrix(ngrams):
    """Associates to each transition the count of its appearance in the sequence"""

    transitions = {}
    for ngram in ngrams:
        ngram_tuple = tuple(ngram)
        if ngram_tuple not in transitions.keys(): 
            transitions[ngram_tuple] = 1
        else:
            transitions[ngram_tuple] += 1

    #normalize to probabilies
    total_ngrams = len(ngrams)
    for k in transitions.keys():
        transitions[k] /= total_ngrams

    return transitions

def interpolate_transition_matrix(base_matrix, horror_matrix, intensity):
    """Interpolates between base and horror transitions, chosing the intensity level of horror"""

    all_keys = set(base_matrix.keys()).union(set(horror_matrix.keys()))
    interpolated_matrix = {}

    for key in all_keys:
        #get probabilities from both matrices, defaults to 0 if key is missing
        base_prob = base_matrix.get(key, 0)
        horror_prob = horror_matrix.get(key, 0)

        #interpolate probabilities
        interpolated_matrix[key] = (1 - intensity) * base_prob + intensity * horror_prob

    return interpolated_matrix



def predict_next_state(note, transitions):
    """Returns next note based on probabilities given by current transition matrix"""

    options = []
    probabilities = []

    for k in transitions.keys():
        if k[0]==note:
            options.append(k[1])
            probabilities.append(transitions[k])

    #re-normalize probabilities of the subset (transitions starting with <note>)
    probabilities = np.array(probabilities) / np.sum(probabilities)

    return np.random.choice(options, p=probabilities)


def generate_melody(note, transitions, length):
    """Generate sequence of defined length."""

    melody = []
    for n in range(length):
        melody.append(predict_next_state(note, transitions))
        note = melody[-1]
    return melody  

  
base_transitions = generate_transition_matrix(base_ngrams)
#base_melody = generate_melody(base_ngrams[0][0], base_transitions, 30)
#print(base_melody)

horror_transitions = generate_transition_matrix(horror_ngrams)
#horror_melody = generate_melody(horror_ngrams[0][0], horror_transitions, 30)
#print(horror_melody)



###############################################################
#
#   OSC SENDER TO SUPERCOLLIDER
#
###############################################################

def start_osc_communication():

    parser = argparse.ArgumentParser()
    # OSC server ip
    parser.add_argument("--ip", default='127.0.0.1', help="The ip of the OSC server")
    # OSC server port (check on SuperCollider)
    parser.add_argument("--port", type=int, default=57120, help="The port the OSC server is listening on")

    # Parse the arguments
    args = parser.parse_args()

    # Start the UDP Client
    client = udp_client.SimpleUDPClient(args.ip, args.port)

    return client

global client
client = start_osc_communication()

# interpolate base and horror transitions based on horror_level
global horror_level
global current_transitions
global note

horror_level = 0
note = base_ngrams[0][0]
current_transitions = interpolate_transition_matrix(base_transitions, horror_transitions, horror_level)

#debug
print("initial transition matrix: done")


def melody_generation_step():
    """Generates and sends one note every second."""

    global note
    next_note = predict_next_state(note, current_transitions)
    midi_note = pretty_midi.note_name_to_number(note)
    # if global horror_level > 0.5, introduce dissonance / higher bpm / etc
    client.send_message("/synth_control", ['play', midi_note])
    note = next_note

    threading.Timer(1.0, melody_generation_step).start() 

# Start the melody generation
melody_generation_step() 



###############################################################
#
#   OSC RECEIVER FROM UNITY
#
###############################################################

def touch_handler(unused_addr, args):
    """Generates new transition matrix by updating horror intensity level"""
    global horror_level, current_transitions  
    horror_level += 0.1
    horror_level = max(0, min(horror_level, 1))  
    current_transitions = interpolate_transition_matrix(base_transitions, horror_transitions, horror_level)

    client.send_message("/sound_control", ['play'])
    
    #debug
    print("new transition matrix: ", current_transitions)


def start_osc_server():
    # Set the IP and port to listen on
    # ip of net: 192.168.1.244
    ip = "192.168.1.244"
    port = 57121  # Ensure this matches the port used in Unity
    
    # Set up dispatcher to map OSC messages to handler functions
    osc_dispatcher = dispatcher.Dispatcher()
    osc_dispatcher.map("/touch", touch_handler)
    
    # Set up the OSC server
    server = osc_server.ThreadingOSCUDPServer((ip, port), osc_dispatcher)
    print(f"Listening on {ip}:{port}")
    server.serve_forever()

start_osc_server()




