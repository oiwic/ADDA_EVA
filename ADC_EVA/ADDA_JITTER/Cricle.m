da = USTCDAC('10.0.2.9',80);
ad = USTCADC(1);
ad.set('mac','1C-1B-0D-38-3F-FB');
da.Open()
ad.Open();

phase_count = 100;  %ɨ����λ�����
trig_count = 1000;  %ÿ�δ�������
amplitude = 10000;  %���η���
offset = 32767;     %����ƫ�õ�ѹ
period = 200;       %100MHz
period_count = 10;  %���10us�Ĳ���
sample_depth = 500; %���������

ad.SetMode(0);
ad.SetSampleDepth(sample_depth);

t = 0:1/period*2*pi:2*pi*(period_count-1/period);
seq = waveform.generate_trig_seq(period_count*period,0);

channelwave_1 = zeros(1,period_count*period) + offset - amplitude;
channelwave_2 = zeros(1,period_count*period) + offset - amplitude;

for k = 1:period_count
    channelwave_1(period*k-period/2+1:period*k) = offset + amplitude;
    channelwave_2(period*k-period/2+1:period*k) = offset + amplitude;
end
% ��������
da.SetIsMaster(1);
da.SetTrigSel(0);
da.WriteSeq(1,0,seq);
da.WriteSeq(2,0,seq);
da.StartStop(15);
da.CheckStatus();

data = zeros(phase_count,2);
%%
for k = 1:phase_count
    phase = (k-1)/phase_count*2*pi;
    da.WriteWave(1,0,[channelwave_1,zeros(1,16)+32768]);
    da.WriteWave(2,0,[channelwave_2,zeros(1,16)+32768]);         
    da.SetTrigCount(trig_count);
    ad.SetTrigCount(trig_count);
    ad.EnableADC();
    da.CheckStatus();
    da.SendIntTrig();
    [ret,I,Q] = ad.RecvData(trig_count,sample_depth);
    I= reshape(I,[sample_depth,trig_count]);
    Q= reshape(Q,[sample_depth,trig_count]);
    diffI = I(2:sample_depth,:) - I(1:(sample_depth-1),:);
    diffQ = Q(2:sample_depth,:) - Q(1:(sample_depth-1),:);
    diffII = diffI(:,2:trig_count) - diffI(:,1:(trig_count-1));
    diffQQ = diffQ(:,2:trig_count) - diffQ(:,1:(trig_count-1));
    if(abs(max(max(diffII)))>8 || abs(max(max(diffQQ)))>8)
        msgbox('��⵽���ζ���','modal');
        figure(1);plot(I);
        figure(2);plot(Q);
    end
    disp(k);pause(0.02);
end
%%
ad.Close();
da.Close();
