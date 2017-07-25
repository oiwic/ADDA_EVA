data = csvread('data4.csv',0,1);
data = data(21:19980);
numpt=length(data);

F_sample=1e9;       %采样率1G
BW = F_sample/numpt;
F_spec = (-numpt/2:(numpt/2-1))*BW;

span  = 6e3;     %信号频率+-span范围都算作信号能量
spanh = 1e2;     %如果信号没有超过1/6的采样频率，则不要改参数

% data = data.*(hanning(numpt));

V_spec = fft(data);
P_spec = 20*log10(abs(V_spec));
P = V_spec.*conj(V_spec);

P = P(2:floor(numpt/2));%取正频率
P_total = sum(P);
index = find(P == max(P));
if (index-floor(span/BW))<=0
    min = 1;
else
    min = (index-floor(span/BW));
end
if (index+floor(span/BW))>=length(P)
    max = length(P);
else
    max = (index+floor(span/BW));
end

P_signal = sum(P(min:max));

SNR = (P_signal/(P_total-P_signal));
SINAD = 10*log10(P_total/(P_total - P_signal));


ENOB=(SINAD-1.76)/6.02;              %有效位，计算公式哪里都有。