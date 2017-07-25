function [bandwidth,power_spec] = spectrum(data,sample_rate)
% Function describe: 该函数用来计算一个二维数组第一行的功率谱,出错了返回空值。
% 计算是以data为电压幅度单位是v，电阻为1ohm来算的。
% Input parameter: 输入参数data是一个二维数组，sample_rate是这段数据的采样率
% Output parameter: 输出的bandwidth的单位是Hz，power_spec的单位是dBm
% Author: 郭成(fortune@mail.ustc.edu.cn)
% Date: 2017.1.11
    dim = size(data);
    if(2 == length(dim))
        [~,n] = size(data);
        bandwidth = (0:(n-1))/n*sample_rate;
        bandwidth = fftshift(bandwidth);
        bandwidth(1:fix(n/2)) =  bandwidth(1:fix(n/2)) - sample_rate;
        power_spec = 20*log10(abs(fft(data(1,:)))/length(data(1,:)));
        power_spec = fftshift(power_spec);
    else
        bandwidth= [];
        power_spec = [];
    end
end