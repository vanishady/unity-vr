import torch
import argparse
from model import OscControlRNN
from pythonosc.udp_client import SimpleUDPClient
from pythonosc import udp_client
from pythonosc import dispatcher, osc_server
import numpy as np

# configuration
MODEL_PATH = "osc_control_rnn.pth"
SC_IP = "127.0.0.1"
SC_PORT = 57120
SC_ADDRESS = "/music_params"

OSC_RCV_IP = "0.0.0.0"           # quando gira sul vr: "192.168.1.244" 
OSC_RCV_PORT = 57121     

SEQ_LENGTH = 10
DIST_BUFFER = [] 

# prediction
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = OscControlRNN(input_size=1).to(device)
model.load_state_dict(torch.load(MODEL_PATH, map_location=device))
model.eval()


###############################################################
#
#   OSC SENDER TO SUPERCOLLIDER
#
###############################################################

def start_osc_communication():

    parser = argparse.ArgumentParser()
    # OSC server ip
    parser.add_argument("--ip", default=SC_IP, help="The ip of the OSC server")
    # OSC server port (check on SuperCollider)
    parser.add_argument("--port", type=int, default=SC_PORT, help="The port the OSC server is listening on")

    # Parse the arguments
    args = parser.parse_args()

    # Start the UDP Client
    client = udp_client.SimpleUDPClient(args.ip, args.port)

    return client


client = start_osc_communication()


def infer_and_send():
    """Se il buffer ha 10 distanze, predici e invia l'ultimo vettore parametri a SC."""
    if len(DIST_BUFFER) < SEQ_LENGTH:
        return

    # Prende le ultime 10 distanze e le converte in tensor [1, 10, 1]
    seq = np.array(DIST_BUFFER[-SEQ_LENGTH:], dtype=np.float32)
    x = torch.tensor(seq).unsqueeze(0).unsqueeze(-1).to(device)  # [1, 10, 1]

    with torch.no_grad():
        y, _ = model(x)                       # y: [1, 10, 6]
        params = y.squeeze(0).cpu().numpy()   # [10, 6]
        last_params = params[-1]              # ultimo timestep (vector di 6)

    # Invio a SuperCollider
    client.send_message(SC_ADDRESS, last_params.tolist())
    print(f"Parametri inviati a SuperCollider su {SC_IP}:{SC_PORT} {SC_ADDRESS} -> {np.round(last_params, 3).tolist()}")



###############################################################
#
#   OSC RECEIVER FROM UNITY
#
###############################################################

def handle_unity_distance(addr, *args):
    """
    Handler per /danger_input inviato da Unity.
    Attende un singolo float normalizzato [0,1].
    """
    if not args:
        return
    try:
        d = float(args[0])
    except (TypeError, ValueError):
        return

    # clamp di sicurezza
    d = max(0.0, min(1.0, d))
    DIST_BUFFER.append(d)
    print(f"Ricevuto da Unity {addr}: {d:.3f} (buffer {len(DIST_BUFFER)}/{SEQ_LENGTH})")
    infer_and_send()


def start_osc_server():
    # Set the IP and port to listen on
    # ip of net: 192.168.1.244
    ip = OSC_RCV_IP
    port = OSC_RCV_PORT 
    
    # Set up dispatcher to map OSC messages to handler functions
    osc_dispatcher = dispatcher.Dispatcher()
    osc_dispatcher.map("/danger_input", handle_unity_distance)
    
    # Set up the OSC server
    server = osc_server.ThreadingOSCUDPServer((ip, port), osc_dispatcher)
    print(f"Listening on {ip}:{port}")
    server.serve_forever()

start_osc_server()