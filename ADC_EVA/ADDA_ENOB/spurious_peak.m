%�ú������س��źŷ����count��α��
function peak = spurious_peak(power_spectrum,count)
    peak = zeros(1,count);
    power_spectrum(power_spectrum == max(power_spectrum)) = []; %ɾ���ź�Ƶ��
    for k = 1:count;
        peak(k) = power_spectrum(power_spectrum == max(power_spectrum));
        power_spectrum(power_spectrum == max(power_spectrum)) = [];
    end
end