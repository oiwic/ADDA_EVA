function [bandwidth,power_spec] = spectrum_linear(data,sample_rate)
% Function describe: �ú�����������һ����ά�����һ�еĹ�����,�����˷��ؿ�ֵ��
% ��������dataΪ��ѹ���ȵ�λ��v������Ϊ1ohm����ġ�
% Input parameter: �������data��һ����ά���飬sample_rate��������ݵĲ�����
% Output parameter: �����bandwidth�ĵ�λ��Hz��power_spec�ĵ�λ��W
% Author: ����(fortune@mail.ustc.edu.cn)
% Date: 2017.1.11
    dim = size(data);
    if(2 == length(dim))
        [~,n] = size(data);
        bandwidth = (0:(n-1))/n*sample_rate;
        bandwidth = fftshift(bandwidth);
        bandwidth(1:fix(n/2)) =  bandwidth(1:fix(n/2)) - sample_rate;
        power_spec = abs(fft(data(1,:))/length(data(1,:))).^2;
        power_spec = fftshift(power_spec);
     else
        bandwidth= [];
        power_spec = [];
    end
end