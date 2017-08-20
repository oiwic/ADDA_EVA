function [offset_code,voltage] = self_correct_offset(target_offset,channel,dmm_ip,dac_ip)
% describe:correct dac offset
% author: guocheng
% date:2017/4/13
% file: self_correct_offset.m

%% 打开设备
dac = USTCDAC(dac_ip,80);
dmm = DMM34465A(dmm_ip);
dac.Open();
dmm.Open();

%% 构建序列与使能通道
dac.StartStop(240);
waveobj = waveform();
seq = waveobj.generate_seq(32);
dac.WriteSeq(channel,0,seq);
dac.StartStop(15);

%% 将dac设置为0幅度输出
dac.WriteWave(channel,0,zeros(1,32)+65535);
dac.CheckStatus();
v_h = dmm.measure();
dac.WriteWave(channel,0,zeros(1,32));
dac.CheckStatus();
v_l = dmm.measure();
slope = (v_h - v_l)/65535;
offset_code = 0;
offset = 1;
while(offset ~= 0)
    dac.WriteWave(channel,0,zeros(1,32)+offset_code+32767);
    dac.CheckStatus();
    voltage = dmm.measure();
    offset = floor((voltage-target_offset)/slope + 0.5);
    offset_code = offset_code - offset;
    if(abs(offset_code>32768))
        error('校正出错！')
    end
end
dmm.Close;
dac.Close;

end

