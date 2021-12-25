function isVerified = indexVerify(S,Signature,Modulus, PublicExponent)
addpath ../lowPass;

% 认证码 
strSignature = Signature;
int32Signature = str2num(strSignature);

s=S(1:length(S)); %如果是双声道则合并

% N=2^nextpow2(length(s));
%     ss = filter(lowPass5000,s);
%     sss = fft(ss,N);
%     sssp = fft(s,N);
%     figure(1);
%     subplot(221);
%     plot(s);
%     subplot(222);
%     plot(abs(sssp(1:N/2)));
%     subplot(223);
%     plot(ss);
%     subplot(224);
%     plot(abs(sss(1:N/2)));
    
sIndex = 1;
for s_i = 1:length(s) 
    if(abs(s(s_i))>= 0.05)
        tem_s(sIndex) = s(s_i);
        sIndex = sIndex+1;
    end
end
s = tem_s;

% s = filter(lowPass5000,s);
% s = awgn(s,60,'measured'); 

% 将信号分割成 x * 8192 的矩阵，每一行即为一段长度为8192的信号片段，存放在矩阵tem中
sum = 1;
x = 1;
len = 4096; % 分段长度
sLen = (length(s)/len)+1;
while x<=sLen 
    for y=1:len               
        if(sum<length(s))
            tem(x, y) = s(1,sum);
        else
            tem(x,y) = 0;
        end
        sum=sum+1;
    end
    x = x+1;
end

%对每个片段都做三层小波分解，取其近似系数绝对值的平均值
i = 1;
while i<=sLen
    t = tem(i,:); % 取第i行
    [C,L] = wavedec(t,3,'db1');% 用db3小波函数进行3层分解
    [cd1,cd2,cd3]=detcoef(C,L,[1,2,3]);%提取第三层的细节分量（高频部分)
    ca3= abs(appcoef(C,L,'db1',3));%提取第三层的近似分量（低频部分）,并取其绝对值
    E(i) = mean(ca3); % 绝对值的平均值
    SD(i) = std(ca3); % 标准差
    %E2 = sprintf('%8.3f',E1); %
    i=i+1;
end

T = [E,SD]; % 拼接一维数组E和SD，得到一维数组T
TString = '';
for i = 1:length(T)/2
    t = sprintf('%8.2f',T(i)); %将T中的数据全部处理为8位字符串
    TString = strcat(TString,t); 
end
for i = length(T)/2+1:length(T)
    t = sprintf('%8.2f',T(i)); %将T中的数据全部处理为8位字符串
    TString = strcat(TString,t); 
end

fprintf('\nTString:%s\n',TString);

hash = GetMD5(TString,'Array','hex'); % 获取数字摘要
isVerified = Verify(Modulus, PublicExponent, hash, int32Signature);
fprintf('hash2:%s', hash);
fprintf('\nIs Verified:%d\n', isVerified);
end