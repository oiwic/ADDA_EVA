%% set parameter
repeat = 1000;
depth = 18000;
frequency = 10e6;
%% create object
da = USTCDAC('10.0.2.7',80);
ad = USTCADC(1);
wavobj = waveform();
%% generate wave and seq
wavobj.frequency = frequency;
wavobj.amplitude = 16000;
wave = wavobj.generate_sine();
seq  = wavobj.generate_seq(length(wave));
%% output wave
da.Open();
da.StartStop(240);
for ch = 1:4
    da.WriteWave(ch,0,wave);
    da.WriteSeq(ch,0,seq);
end
da.StartStop(15);
da.CheckStatus();
%% sample data
Q = zeros(repeat,depth);
I = zeros(repeat,depth);
ad.set('mac','FF-FF-FF-FF-FF-FF');
ad.Open();
ad.SetSampleDepth(depth);
for  k = 1:repeat
    ad.ForceTrig();
    [ret,I(k,:),Q(k,:)] = ad.RecvData(1,depth);
    while(ret ~= 0)
        ad.ForceTrig();
        [ret,I(k,:),Q(k,:)] = ad.RecvData(1,depth);
    end
end
%% analysis data
[SINAD_I,SNR_I,SFDR_I,THD_I,ENOB_I] = analysis(I,1e9);
[SINAD_Q,SNR_Q,SFDR_Q,THD_Q,ENOB_Q] = analysis(Q,1e9);
%% close object
ad.Close();
da.Close();