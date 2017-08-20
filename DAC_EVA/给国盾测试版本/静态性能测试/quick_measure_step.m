function step_data = quick_measure_step(repeat,channel,dac_ip,dmm_ip)
%QUICK_MEASURE_STEP 此处显示有关此函数的摘要
%   此处显示详细说明
dac = USTCDAC(dac_ip,80);
dmm = DMM34465A(dmm_ip);
dac.Open();
dmm.Open();
step = generate_step();
wave_obj = waveform();
seq = wave_obj.generate_seq(32);
dac.WriteSeq(channel,0,seq);
step_data = zeros(length(step),repeat);
h = waitbar(0,'Please wait...');
for t = 1:length(step)
    dac.WriteWave(channel,0,zeros(1,32)+step(t));
    dac.StartStop(15);
    dac.CheckStatus();
    step_data(t,:) = dmm.measure_count(repeat);
    waitbar(t/length(step),h,[num2str(t/length(step)*100) '%'])
end

close(h);
dmm.Close();
dac.Close();

end

