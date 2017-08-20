function data = measure_step(channel,start,step,stop,repeat,loop,dac_ip,dmm_ip)
% describe: acquire step data
% author: guocheng
% version: 1.0
% date: 2017/1/4
% file: measure_step.m
dac = USTCDAC(dac_ip,80);
dmm = DMM34465A(dmm_ip);
wave_obj = waveform();
row = floor((stop-start)/step)+1;
column = loop*repeat;
data = zeros(row,column);
global test_console_exit_flag;
for k = 1:loop
    count  = 1;
    for dc = start:step:stop
        wave = wave_obj.generate_dc(32,dc);
        dac.WriteWave(channel,0,wave);
        dac.StartStop(15);
        data(count,repeat*(k-1)+1:repeat*k) = dmm.measure_count(repeat);
        percent = ((k-1)*row+count)/(row*loop)*100;
        disp(['Íê³É£º',num2str(percent),'%']);
        count = count + 1;
        if(mod(count,1000) == 0)
            save tempfile data
        end
        if(test_console_exit_flag == 1)
            break;
        end
        pause(0.01);
    end
    if(test_console_exit_flag == 1)
        break;
    end
end
dmm.close();
dac.close();
end

