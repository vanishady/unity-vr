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
s.reboot;

/*------------------------ Stop everything -----------------------------*/
Server.killAll;

/*------------------------ Synth -----------------------------*/

(
~selectedpath = "./sounds/hand_whisper.wav";
~buf = Buffer.readChannel(Server.default, ~selectedpath, channels:[0]);
)

(
~selectedpath2 = "./sounds/background_whisper.wav";
~buf2 = Buffer.readChannel(Server.default, ~selectedpath2, channels:[0]);
)

(
~pathambiance = "./sounds/ambiance.wav";
~bufambiance = Buffer.readChannel(Server.default, ~pathambiance, channels:[0]);
)

// buffer testing instruction
~buf.numChannels;
~buf.play;

(
SynthDef.new(\sampler, {

	arg out=0, rate=1, amp=0.5, buffer=0;

	var signal;

	signal = PlayBuf.ar(1, buffer,
		BufRateScale.kr(buffer)*rate,
		doneAction:2);

	Out.ar(out, signal!2 * amp);

}).add;
)


(
SynthDef.new(\looper, {

	arg out=0, rate=1, amp=0.5, buffer=0;

	var signal, rev, pan;

	signal = PlayBuf.ar(1, buffer,
		BufRateScale.kr(buffer)*rate,
		loop:1);

	rev = FreeVerb.ar(signal);

	pan = Pan2.ar(rev, FSinOsc.kr(0.1, mul: 0.2));

	Out.ar(out, pan * amp);

}).add;
)

(
s.waitForBoot {
    Synth(\looper, [\buffer, ~bufambiance.bufnum, \rate, 1.0, \amp, 5]);
};
)

(
SynthDef(\simpleSynth, { |freq = 440, amp = 0.5|
    var env = EnvGen.kr(
        Env.perc(0.01, 1.1),
        doneAction: 2
    );
    var sig = SinOsc.ar(freq) * env * amp;
    Out.ar(0, sig!2);
}).add;
)



/*------------------------ Receiver -----------------------------*/
NetAddr.langPort

(
OSCdef.new(
	\playNote,
	{ arg msg;

		var command = msg[1];
		var note = msg[2];
		[msg].postln;

		if (command == 'play') {
			var freq = note.midicps;
			Synth(\simpleSynth, [\freq, freq, \amp, 0.5]);
		}
    }, '/synth_control');
)

(
OSCdef.new(
	\playSound,
	{ arg msg;

		var command = msg[1];
		[msg].postln;

		if (command == 'play') {
			Synth(\sampler,[\buffer,~buf]);
		}
    }, '/sound_control');
)

/*------------------------ Quit -----------------------------*/
s.quit
