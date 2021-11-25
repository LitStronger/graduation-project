% 模与公钥
Modulus = 3901;
PublicExponent = 3; 

% 认证码 
strSignature = '1102   964  3009  1102  3752  3173  2225   157  2885  3752  2885  3173  3173  2225  3611  3611  2885  2225  2225  2885  3741  3752  1102  3308   537   157  2570  2885   157   921   921  3308';
int32Signature = str2num(strSignature);

%[S, Fs]=audioread('../assets/audio-raw.aac'); % Fs 原音频
%[S, Fs]=audioread('../assets/audio-ditong.aac'); % Fs 低通处理
%[S, Fs]=audioread('../assets/audio-revert.aac'); % Fs 片段倒装处理 
%[S, Fs]=audioread('../assets/audio-noise.aac'); % Fs 降噪处理
%[S, Fs]=audioread('../assets/audio-resample_44.1khz.aac'); % Fs 重采样处理

s=S(1:length(S)); %如果是双声道则合并

% 将信号分割成 x * 8192 的矩阵，每一行即为一段长度为8192的信号片段，存放在矩阵tem中
sum = 1;
x = 1;
len = 8192; % 分段长度
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
    t = sprintf('%8.1f',T(i)); %将T中的数据全部处理为8位字符串
    TString = strcat(TString,t); 
end
for i = length(T)/2+1:length(T)
    t = sprintf('%8.1f',T(i)); %将T中的数据全部处理为8位字符串
    TString = strcat(TString,t); 
end

% deT = strsplit(TString);
% data = str2num(cell2mat(deT(3)));

hash = GetMD5(TString,'Array','hex'); % 获取数字摘要

IsVerified = Verify(Modulus, PublicExponent, hash, int32Signature);
fprintf('Is Verified:%d\n', IsVerified)








