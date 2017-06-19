function data = stability(elapse, dmm_ip )
% describe:histogram voltage distribute
% author: guocheng
% date:2017/1/5
% file: stability_test.m
dmm = DMM34465A(dmm_ip);

temp = zeros(1,8000000);%max 8M sample
start_tic = clock;
counter = 0;
global test_console_exit_flag;
while(elapse > etime(clock,start_tic))
    counter = counter+1;
    temp(counter) = dmm.measure();
    h1 = histogram(temp(1:counter),'BinMethod','scott');hold on;
    limits = get(h1,'BINLIMITS');
    bincount = get(h1,'NUMBINS');
    x = linspace(limits(1),limits(2),1000);
    y = normpdf(x,mean(temp(1:counter)),std(temp(1:counter)));
    y = counter/bincount*y/mean(y);
    plot(x,y,'color','r','LineWidth',2);hold off;
    percent = etime(clock,start_tic)/elapse*100;
    disp(['已经完成：',num2str(percent),'%']);
    pause(0.05)
    if(test_console_exit_flag == 1)
        break;
    end
end

data = temp(1:counter);

dmm.close();

end

