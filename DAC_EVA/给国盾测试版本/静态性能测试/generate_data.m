function data = generate_data( step_data )
%GENERATE_DATA 根据部分台阶数据生成所有台阶数据
%   5-7-4模型组建原始数据
step_data = step_data - step_data(1);
data = zeros(65536,1);
data(1) = step_data(1);
for k = 2:65535
    high = floor((k-1)/2048);
    middle = floor(mod(k-1,2048)/16);
    low = mod(mod(k-1,2048),16);
    if(high>0)
        data(k) =  step_data(132+high);
    end
    if(middle>0)
        data(k) = data(k)+step_data(5+middle);
    end
    if(floor(low/8)>0)
        data(k) = data(k) + step_data(5);
    end
    if(floor(mod(low,8)/4)>0)
        data(k) = data(k) + step_data(4);
    end
    if(floor(mod(low,4)/2)>0)
        data(k) = data(k) + step_data(3);
    end
    if(mod(low,2)>0)
        data(k) = data(k) + step_data(2);
    end
end
data(65536) = step_data(164);
end

