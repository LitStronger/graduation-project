n=211134.555;
m=10;%����10λС��
d=n*2^m;
[f,e]=log2(d);
a=char(mod(floor(d*2.^(1-e:0)),2)+'0');
a=[a(1:end-m),'.',a(end-m+1:end)]