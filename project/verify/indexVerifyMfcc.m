function isVerified = indexVerify(S, Fs,Signature,Modulus, PublicExponent)

% 认证码 
strSignature = Signature;
int32Signature = str2num(strSignature);

s=S(1:length(S)); %双声道处理

sIndex = 1;
for s_i = 1:length(s) 
    if(abs(s(s_i))>= 0.05)
        tem_s(sIndex) = s(s_i);
        sIndex = sIndex+1;
    end
end
s = tem_s;
%s = awgn(s,100,'measured'); % 加噪

% 将信号分割成 x * 4096 的矩阵，每一行即为一段长度为4096的信号片段，存放在矩阵tem中
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
    mfccs = getMfcc(t,Fs);
    [mfccs_r,mfccs_c] = size(mfccs);    % 读取行r、列c
    for r = 1:mfccs_r        % 建立for循环嵌套
       for c = 1:mfccs_c
            if(isnan(mfccs(r,c)))
                mfccs(r,c) = 0;     % 读取矩阵每个位置数据，先行后列
            end
       end
    end
    mfccs = mfccs(:); % 二维转一维
    E(i) = mean(mfccs); % 平均值
    SD(i) = std(mfccs); % 标准差
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

hash = GetMD5(TString,'Array','hex'); % 获取数字摘要
isVerified = Verify(Modulus, PublicExponent, hash, int32Signature);
%fprintf('%s\n', hash);
fprintf('Is Verified:%d\n', isVerified);
end