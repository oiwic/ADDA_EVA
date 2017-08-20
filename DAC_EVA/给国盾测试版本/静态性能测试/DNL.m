function RET = DNL(DATA)
    Y = mean(DATA,2);
    n = length(Y);
    if(n ~= 1)
    LSB_IDEAL = (Y(n) - Y(1))/(n-1);
    RET(1) = 0;
    RET(2:n) = (Y(2:n) - Y(1:n-1))/LSB_IDEAL - 1;
    else
        RET = 0;
    end
end