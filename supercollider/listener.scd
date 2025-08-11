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

/*------------------------ Looper -----------------------------*/

(
~pathambiance = "./sounds/ambiance.wav";
~bufambiance = Buffer.readChannel(Server.default, ~pathambiance, channels:[0]);
)

// buffer testing instruction
~buf.numChannels;
~bufambiance.play;



/*------------------------ Receiver -----------------------------*/
NetAddr.langPort

(
OSCdef.new(
    \receiveParams,
    { |msg, time, addr, port|
        "Ricevuti parametri da Python: %\n".postf(msg[1..]);  // msg[0] è l'indirizzo OSC
    },
    '/music_params',  // indirizzo OSC da ascoltare
    recvPort: 57120   // deve coincidere con la porta su cui Python invia
);
)


/*------------------------ Quit -----------------------------*/
s.quit
