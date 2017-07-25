function [SINAD,SNR,SFDR,THD,ENOB] = analysis(data,sample_rate)
    [m,~] = size(data);
    SINAD = zeros(m,1);
    SNR = zeros(m,1);
    SFDR = zeros(m,1);
    THD = zeros(m,1);
    ENOB = zeros(m,1);
    for k = 1:m
        [bandwidth,power_spec] = spectrum_linear(data(k,:),sample_rate);
        power_spec_p = power_spec(bandwidth>0);%db
        peak = spurious_peak(power_spec_p,5);
        
        power_signal = max(power_spec_p);
        power_distortion = sum(peak);
        power_noise = sum(power_spec_p) - power_signal - power_distortion;
        
        SINAD(k) = 10*log10((power_signal+power_distortion+power_noise)/(power_distortion + power_noise)); 
        SNR(k)   = 10*log10(power_signal/power_noise);
        SFDR(k)  = 10*log10(power_signal/peak(1));
        THD(k)   = 10*log10(power_signal/sum(peak));
        ENOB(k)  = (SINAD(k) - 1.76)/6.02;
    end
    figure(1)
    histogram(SINAD);
    title(['SINAD','  AVG = ',num2str(mean(SINAD)),'  SIGMA = ',num2str(std(SINAD))]);
    xlabel('db');
    ylabel('count');
    figure(2)
    histogram(SNR);
    title(['SNR','  AVG = ',num2str(mean(SNR)),'  SIGMA = ',num2str(std(SNR))]);
    xlabel('db');
    ylabel('count');
    figure(3)
    histogram(SFDR);
    title(['SFDR','  AVG = ',num2str(mean(SFDR)),'  SIGMA = ',num2str(std(SFDR))]);
    xlabel('dbc');
    ylabel('count');
    figure(4)
    histogram(THD);
    title(['THD','  AVG = ',num2str(mean(THD)),'  SIGMA = ',num2str(std(THD))]);
    xlabel('db');
    ylabel('count');
    figure(5)
    histogram(ENOB);
    title(['ENOB','  AVG = ',num2str(mean(ENOB)),'  SIGMA = ',num2str(std(ENOB))]);
    xlabel('ÓÐÐ§Î»');
    ylabel('count');
end