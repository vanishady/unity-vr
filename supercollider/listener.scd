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

		~ambSynth.set(\rev_depth, rev_depth);
    },
    '/music_params',  // indirizzo OSC da ascoltare
    recvPort: 57120   // deve coincidere con la porta su cui Python invia
);
)


/*------------------------ Quit -----------------------------*/
s.quit
