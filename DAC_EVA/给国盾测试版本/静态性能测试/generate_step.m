function step = generate_step()
%GENERATE_STEP 用来生成测试台阶的函数
%   5-7-4的DAC结构
    pre = 0;
    seg1 = [1 2 4 8];
    seg2 = 16:16:2047;
    seg3 = 2048:2048:65535;
    suf = 65535;
    step = [pre seg1 seg2 seg3 suf];
end

