repeat = 1000;
depth = 18000;

da = USTCDAC('10.0.1.1',80);
ad = USTCADC(2);
wavobj = waveform();

da.Open();
da.Init();
da.StartStop(240);
da.SetIsMaster(1);
da.SetTrigCount(repeat);
da.SetTrigInterval(400e-6);
da.StartStop(15);
da.CheckStatus();

ad.Open();
mac=['ff';'ff';'ff';'ff';'ff';'ff'];
mac = uint32(hex2dec(mac));
ad.SetMacAddr(mac');
ad.SetTrigCount(repeat);
ad.SetSampleDepth(depth);
ad.EnableADC();

wavobj.frequency = 10e6;
wave = wavobj.generate_sine();
seq  = wavobj.generate_trig_seq(length(wave),0);
wave = [wave,ones(1,16)*32768];

[ret,I,Q] = ad.RecvData(repeat,depth);
while(ret ~= 0)
    ad.EnableADC();
    da.SendIntTrig()
    [ret,I,Q] = ad.RecvData(repeat,depth);
end
ad.Close();
da.Close();
[SINAD_I,SNR_I,SFDR_I,THD_I,ENOB_I] = analysis(I,1e9);
[SINAD_Q,SNR_Q,SFDR_Q,THD_Q,ENOB_Q] = analysis(Q,1e9);