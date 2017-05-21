function d = differ(m,n,u0,v0,c)
%return partial derivative with respect to c variable of cuntion func. 
add = zeros(2);
add(c) = 0.001;
%disp(add)
d = (sum(func(m,n,u0+add(1),v0 + add(2))) - sum(func(m,n,u0,v0)))/(0.001);


