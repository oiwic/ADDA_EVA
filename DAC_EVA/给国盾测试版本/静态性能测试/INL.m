function RET = INL(DATA)
    Y = DNL(DATA);
    RET = zeros(1,length(Y));
    for k = 2:length(Y)
        RET(k) = RET(k-1)+Y(k);
    end
end