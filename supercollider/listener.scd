/*------------------------ Setup instructions -----------------------------*/

s.options.blockSize = 1024;
s.options.numBuffers = 64;
s.options.numWireBufs = 128;
s.options.hardwareBufferSize = 2048;

s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;
s.options.memSize = 8192;
s.options.sampleRate = 48000;
s.latency = 0;

s.boot;

Server.default.options.inDevice = "Microphone (Realtek(R) Audio)";
Server.default.options.outDevice = "Speakers (Realtek(R) Audio)";
ServerOptions.outDevices;
ServerOptions.inDevices;
Server.default.options.inDevice = "Headset Microphone (Oculus Virtual Audio Device)";
Server.default.options.outDevice = "Cuffie (Oculus Virtual Audio Device)";
s.reboot;

/*------------------------ Stop everything -----------------------------*/
Server.killAll;

/*------------------------ Looper -----------------------------*/

(
~pathambiance = "../sounds/ambiance.wav";
~bufambiance = Buffer.readChannel(Server.default, ~pathambiance, channels:[0]);
)

// buffer testing instruction
~buf.numChannels;
~bufambiance.play;

// looper for music
(
SynthDef.new(\looper, {

	arg out=0, rate=1, amp=0.5, buffer=0, rev_depth=0.0;

	var signal, rev, pan;

	signal = PlayBuf.ar(1, buffer,
		BufRateScale.kr(buffer)*rate,
		loop:1);

	rev = FreeVerb.ar(signal, mix:rev_depth);

	pan = Pan2.ar(rev, FSinOsc.kr(0.1, mul: 0.2));

	Out.ar(out, pan * amp);

}).add;
)

(
s.waitForBoot {
    ~ambSynth = Synth(\looper, [\buffer, ~bufambiance.bufnum, \rate, 1.0, \amp, 0.5]);
};
)

// prova manualmente
//~ambSynth.set(\rev, 0.8); // aumenta riverbero


/*------------------------- Drone -------------------------------*/

(
s.waitForBoot {
  Spec.add (\freq1,  #[20,    10000, \exp, 0, 100]);
  Spec.add (\freq2,  #[20,    10000, \exp, 0, 200]);
  Spec.add (\freq3,  #[20,    10000, \exp, 0, 300]);

  Spec.add (\fmod1,  #[0.001, 100,   \exp, 0, 0.11]);
  Spec.add (\fmod2,  #[0.001, 100,   \exp, 0, 0.22]);
  Spec.add (\fmod3,  #[0.001, 100,   \exp, 0, 0.33]);

  Spec.add (\fmoda1, #[0,     100,   \lin, 0, 1]);
  Spec.add (\fmoda2, #[0,     100,   \lin, 0, 1]);
  Spec.add (\fmoda3, #[0,     100,   \lin, 0, 1]);

  Spec.add (\pmod1,  #[0.001, 100,   \exp, 0, 0.1]);
  Spec.add (\pmod2,  #[0.001, 100,   \exp, 0, 0.2]);
  Spec.add (\pmod3,  #[0.001, 100,   \exp, 0, 0.3]);

  Spec.add (\amod1,  #[0.001, 100,   \exp, 0, 0.01]);
  Spec.add (\amod2,  #[0.001, 100,   \exp, 0, 0.02]);
  Spec.add (\amod3,  #[0.001, 100,   \exp, 0, 0.03]);

  Spec.add (\amoda1, #[0,     10,    \lin, 0, 0.05]);
  Spec.add (\amoda2, #[0,     10,    \lin, 0, 0.05]);
  Spec.add (\amoda3, #[0,     10,    \lin, 0, 0.05]);

  Spec.add (\smod,   #[0.001, 100,   \exp, 0, 0.13]);
  Spec.add (\smoda,  #[0,     100,   \lin, 0, 5]);
  Spec.add (\smodm,  #[0,     100,   \lin, 0, 6]);
  Spec.add (\smodaa, #[0,     100,   \lin, 0, 8]);
  Spec.add (\smodmm, #[0,     100,   \lin, 0, 50]);

  Spec.add (\cmod,   #[0.001, 100,   \exp, 0, 1.2]);
  Spec.add (\cmoda,  #[0,     10,    \lin, 0, 0.6]);

  Spec.add (\room,   #[0,     300,   \lin, 1, 20]);
  Spec.add (\reverb, #[0,     30,    \lin, 0, 5]);
  Spec.add (\damp,   #[0,     1,     \lin, 0, 1]);
  Spec.add (\input,  #[0,     1,     \lin, 0, 0.5]);
  Spec.add (\spread, #[0,     100,   \lin, 0, 25]);
  Spec.add (\dry,    #[0,     1,     \lin, 0, 0]);
  Spec.add (\early,  #[0,     1,     \lin, 0, 1]);
  Spec.add (\tail,   #[0,     1,     \lin, 0, 1]);

  Ndef(\droneSines).play;

  Ndef(\droneSines, {
		// Base frequencies
    arg freq1  = 100,
        freq2  = 200,
        freq3  = 300,

		// Frequency modulation
        fmod1  = 0.11,
        fmod2  = 0.22,
        fmod3  = 0.33,
        fmoda1 = 1,
        fmoda2 = 1,
        fmoda3 = 1,

		// Phase modulation
        pmod1  = 0.1,
        pmod2  = 0.2,
        pmod3  = 0.3,

		// Amplitude modulation
        amod1  = 0.01,
        amod2  = 0.02,
        amod3  = 0.03,
        amoda1 = 0.05,
        amoda2 = 0.05,
        amoda3 = 0.05,

		// Stereo field modulation
        smod   = 0.13,
        smoda  = 5,
        smodm  = 6,
        smodaa = 8,
        smodmm = 50,
        cmod   = 1.2,
        cmoda  = 0.6,

		// Reverb parameters
        room   = 20,
        reverb = 5,
        damp   = 1,
        input  = 0.5,
        spread = 25,
        dry    = 0,
        early  = 1,
        tail   = 1,

		// Amplitude multiplier
        amp    = 0.7;

    Limiter.ar (
      LeakDC.ar (
        GVerb.ar (
          Splay.ar (
            SinOsc.ar (
              [freq1, freq2, freq3] + SinOsc.ar ([fmod1, fmod2, fmod3], 0, [fmoda1, fmoda2, fmoda3]),
              SinOsc.ar ([pmod1, pmod2, pmod3], 0, 2pi),
              SinOsc.ar ([amod1, amod2, amod3], 0, [amoda1, amoda2, amoda3])),
            SinOsc.ar (SinOsc.ar (SinOsc.ar (smod, 0, smoda, smodm), 0, smodaa, smodmm), 0, 1, 1),
          amp,
          SinOsc.ar (cmod, 0, cmoda)),
        room, reverb, damp, input, spread, dry, early, tail)));
  });
};
)

(
  // GUI and meter (to debug)
  Ndef(\droneSines).edit;
  s.meter;
)

Ndef(\droneSines).stop;

// Save preset
Ndef(\droneSines).nodeMap.writeArchive ("pset1.txt".standardizePath);

// Load preset
Ndef(\droneSines).nodeMap = Object.readArchive ("pset1.txt".standardizePath);


/*------------------------ Receiver -----------------------------*/
NetAddr.langPort

(
OSCdef.new(
    \receiveParams,
    { |msg, time, addr, port|

		var timbre = msg[1];
		var dissonance = msg[2];
		var unison = msg[3];
		var rev_depth = msg[4];
		var cutoff = msg[5];
		var intensity = msg[6];

		"Ricevuti parametri da Python: %\n".postf(msg[1..]);

		//~ambSynth.set(\rev_depth, rev_depth);

		Ndef(\droneSines).set (
			\freq1,  timbre,
			\fmod1,  dissonance,
			\spread, unison,
			\reverb, rev_depth,
			\pmod1,  cutoff,
			\input,  intensity
		);
    },
    '/music_params',  // indirizzo OSC da ascoltare
    recvPort: 57120   // deve coincidere con la porta su cui Python invia
);
)


/*------------------------ Quit -----------------------------*/
s.quit
