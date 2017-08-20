% file_name:send_continuous_wave.m
% describe:used to send continuous wave to dac all channels.
% ip:dac's ip
% type:waveform type,1 is sine,2 is square,3  is raw,4 is dc,
% frequency:the frequency of dac to output
% dBFS: dB full scall of dac output
% Date:2017/3/21
% Author:guocheng
% E-mail:fortune@mail.ustc.edu.cn

function send_continuous_wave(ip,type,frequency,dBFS) 
    waveobj = waveform();
    waveobj.frequency = frequency;
    if(type == 4)
        waveobj.offset = dBFS;
    else
        waveobj.amplitude = 10^(dBFS/20)*65535;
    end
    
    switch(type)
        case 1
            wave = waveobj.generate_sine();
        case 2;
            wave = waveobj.generate_squr();
        case 3;
            wave = waveobj.generate_raw();
        case 4;
            wave = waveobj.generate_dc();
        otherwise
            wave = ones(1,32768)*32768;
    end
    da = USTCDAC(ip,80);
    da.Open();
    seq  = waveobj.generate_seq(length(wave));   
    for k = 1:4
        da.WriteWave(k,0,wave);
        da.WriteSeq(k,0,seq);  
    end
    da.StartStop(15); 
    da.CheckStatus();
    da.Close();
end