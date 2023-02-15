function B = catmap(A)
% Discrete cat map. See https://en.wikipedia.org/wiki/Arnold%27s_cat_map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A: input image as a 3-array
% B: iterated image as a 3-array

k=length(A);

for n=1:k
    for m=1:k
        if mod(2*n+m,k) == 0
            n1=k;
        else
            n1 = mod(2*n+m,k);
        end
        if mod(n+m,k) == 0
            m1=k;
        else
            m1 = mod(n+m,k);
        end
        for i=1:3
        B(n1,k+1-m1,i)=A(n,k+1-m,i);
        end
    end
end

end

