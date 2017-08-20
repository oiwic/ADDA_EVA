% 仅供self_correct_gain.m使用
function voltage = measure_vpp(dmm,dac,ch)
    dac.WriteWave(ch,0,zeros(1,32)+65535);
    dac.CheckStatus();
    voltage_h = dmm.measure();
    dac.WriteWave(ch,0,zeros(1,32));
    dac.CheckStatus();
    voltage_l = dmm.measure();
    voltage = abs(mean(voltage_h - voltage_l));
end