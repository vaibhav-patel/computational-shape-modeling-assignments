function poly = func(m,n,u,v)
%return value at u,v point with polynomial of m terms and n power
ind = 1;   %index which will represent each coefficient corresponding term in polynomial and vector a 
poly = zeros(m,1);
for i = 1:n+1
    for j = 1:i
        poly(ind) = v^(j-1)*u^(i-j);
        ind = ind + 1;
    end;
end;