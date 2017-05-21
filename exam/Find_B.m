function B= Find_B (Dx,DZ,epsilon,n)
B=zeros(n,n);
for i1=1:n
    for j1=1:n
        if(DZ(i1,j1)-epsilon >=0 )
            B(i1,j1)=-Dx(i1,j1)/DZ(i1,j1);
        end
    end
end
B(isnan(B))=0;
for i1=1:n
    B(i1,i1)=-sum(B(i1,:));
end


