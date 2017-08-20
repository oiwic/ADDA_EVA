% file_name:send_continuous_wave.m
% describe:used to send continuous wave to dac all channels.
% ip:dac's ip
% delay:the clock count,every clock is 4ns.
% Date:2017/3/21
% Author:guocheng
% E-mail:fortune@mail.ustc.edu.cn

function send_trigger_wave(ip,delay) 
    wave = [zeros(1,64),ones(1,64)*32768];
    waveobj = waveform();
    seq  = waveobj.generate_trig_seq(length(wave),delay);
    wave = [wave,ones(1,16)*32768];
    da = USTCDAC(ip,80);
    da.Open();
    da.StartStop(240); 
    for k = 1:4
        da.WriteWave(k,0,wave);
        da.WriteSeq(k,0,seq);  
    end
    da.StartStop(15);
    da.SetIsMaster(1);
    da.SetTrigSel(3);
    da.SendIntTrig();
    da.CheckStatus();
    da.Close();
end