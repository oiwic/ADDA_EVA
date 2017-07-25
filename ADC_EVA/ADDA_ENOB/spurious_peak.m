%该函数返回除信号峰外的count个伪峰
function peak = spurious_peak(power_spectrum,count)
    peak = zeros(1,count);
    power_spectrum(power_spectrum == max(power_spectrum)) = []; %删除信号频率
    for k = 1:count;
        peak(k) = power_spectrum(power_spectrum == max(power_spectrum));
        power_spectrum(power_spectrum == max(power_spectrum)) = [];
    end
end