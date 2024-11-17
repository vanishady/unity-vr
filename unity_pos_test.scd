/*------------------------ Setup instructions -----------------------------*/

s.quit;
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

/*------------------------ Stop everything -----------------------------*/
Server.killAll;

/*----------------------- Choice of song --------------------------------*/

(
~selectedpath = "C:/Users/Very/Desktop/sc_for_unity/sounds/blip.wav";
~selectedpath2 = "C:/Users/Very/Desktop/sc_for_unity/sounds/horror.wav";
~buf = Buffer.readChannel(Server.default, ~selectedpath, channels:[0]);
~buf2 = Buffer.readChannel(Server.default, ~selectedpath2, channels:[0]);
)

// buffer testing instruction
~buf.numChannels;
~buf.play;
~buf2.play;

Server.default.options.inDevice = "Microphone (Realtek(R) Audio)";
Server.default.options.outDevice = "Speakers (Realtek(R) Audio)";
s.reboot;
//~audioBus = Bus.audio(s,2);
//~audioBus.scope;



/*---------------------- SynthDef -------------------------------*/

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


/*----------------------------- Sender -------------------------------*/
~addrsend = NetAddr.new("127.0.0.1", 7000);
~addrsend.sendMsg("/test", ~path);


/*----------------------------- Receiver -------------------------------*/

NetAddr.localAddr;

(
OSCdef.new(
	\eulers,
	{arg msg;
		[msg].postln;
		Synth(\sampler,[\buffer,~buf]);

	},
	'/eulers',
	nil, 57120
))

(
OSCdef.new(
	\touch,
	{arg msg;
		[msg].postln;
		Date.getDate.postln;
		Synth(\sampler,[\buffer,~buf2]);

	},
	'/touch',
	nil, 57120
))

