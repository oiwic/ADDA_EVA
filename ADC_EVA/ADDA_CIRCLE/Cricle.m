da = USTCDAC('10.0.2.11',80);
ad = USTCADC(1);
ad.set('mac','1C-1B-0D-38-3F-FB');
da.Open()
ad.Open();

phase_count = 100; %扫描相位点个数
trig_count = 1000;  %每次触发个数
amplitude = 1000;  %波形幅度
offset = 32767;     %波形偏置电压
period = 20;        %100MHz
period_count = 1000;%输出10us的波形
sample_depth = 5000;%采样点个数


ad.SetMode(1);
ad.SetWindowStart(8);
ad.SetWindowLength(sample_depth);
ad.SetSampleDepth(sample_depth);
ad.SetDemoFre(100e6);

t = 0:1/period*2*pi:2*pi*(period_count-1/period);
seq = waveform.generate_trig_seq(period_count*period,0);

da.SetIsMaster(1);
da.SetTrigSel(0);
da.WriteSeq(1,0,seq);
da.WriteSeq(2,0,seq);
da.StartStop(3);
da.CheckStatus();

data = zeros(phase_count,2);

for k = 1:phase_count
    phase = (k-1)/phase_count*2*pi;
    channelwave_1 = amplitude*cos(t+phase)+offset;
    channelwave_2 = amplitude*sin(t+phase)+offset;
    da.WriteWave(1,0,channelwave_1);
    da.WriteWave(2,0,channelwave_2);
          
    da.SetTrigCount(trig_count);
    ad.SetTrigCount(trig_count);
    ad.EnableADC();
    da.CheckStatus();
    da.SendIntTrig();
    [ret,I,Q] = ad.RecvDemo(trig_count);
    data(k,1) = mean(double(I))/256/sample_depth*2;
    data(k,2) = mean(double(Q))/256/sample_depth*2;
    scatter(data(1:k,1),data(1:k,2))
    pause(0.02);
end
