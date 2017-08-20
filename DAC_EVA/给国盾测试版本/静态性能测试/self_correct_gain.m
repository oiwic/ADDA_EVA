function [gain_code,voltage] = self_correct_gain( target_voltage,channel,dmm_ip,dac_ip)
% describe:����źŵ����ĵ�ѹΪ0V
% author: guocheng
% date:2017/4/13
% file: self_correct_gain.m

%% ���豸
dac = USTCDAC(dac_ip,80);
dmm = DMM34465A(dmm_ip);
dac.Open();
dmm.Open();

%% ���������ģʽ����ʼ���
dac.StartStop(240);
waveobj = waveform();
seq  = waveobj.generate_seq(32);
dac.WriteSeq(channel,0,seq);
dac.StartStop(15);
dac.CheckStatus();

%% ִ������У���㷨
dac.SetGain(channel,511);
dac.CheckStatus();
v_h = measure_vpp(dmm,dac,channel);
dac.SetGain(channel,512);
dac.CheckStatus();
v_l = measure_vpp(dmm,dac,channel);
slope = (v_h - v_l)/1023;
gaincode = [512:1023,0:511]; 
offset = -1;
offset_code = 513;
while(0 ~=offset)
    dac.SetGain(channel,gaincode(offset_code))
    dac.CheckStatus();
    voltage = measure_vpp(dmm,dac,channel);
    offset = floor((voltage - target_voltage)/slope + 0.5);
    offset_code = offset_code - offset;
    if(offset_code>1023 || offset_code<0)
        error('У������')
    end
end
gain_code = gaincode(offset_code);

dac.Close();
dmm.Close();

end

