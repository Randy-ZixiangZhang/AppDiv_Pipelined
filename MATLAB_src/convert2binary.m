function z = convert2binary(a,n,m)
    
z = fix(rem(a*pow2(-(n-1):m),2)); 
%b2d = d2b*pow2(n-1:-1:-m).';
end