Modulus = 1027;
PrivateExponent = 749;

% audioread函数读取音频文件（X--保存音频信号的数据；Fs--音频采样率）
[S, Fs]=audioread('../assets/test_assets/raw/audio_test1_Sub_01.aac'); % Fs 原音频
%[S, Fs]=audioread('../assets/test_assets/tamper_2.5%/audio_test1_Sub_07.aac'); % Fs 篡改音频

%[S, Fs]=audioread('../assets/audio-ditong.aac'); % Fs 低通处理
%[S, Fs]=audioread('../assets/audio-revert.aac'); % Fs 片段倒装处理 
%[S, Fs]=audioread('../assets/audio-noise.aac'); % Fs 降噪处理
%[S, Fs]=audioread('../assets/audio-resample_44.1khz.aac'); % Fs 重采样处理

s=S(1:length(S)); %如果是双声道则合并

%s=s+normrnd(0,0.005);% 加噪

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
    t = sprintf('%8.2f',T(i)); %将T中的数据全部处理为8位字符串，整数部分四位，小数点后保留三位
    TString = strcat(TString,t); 
end
for i = length(T)/2+1:length(T)
    t = sprintf('%8.2f',T(i)); %将T中的数据全部处理为8位字符串，整数部分四位，小数点后保留三位
    TString = strcat(TString,t); 
end

% deT = strsplit(TString);
% data = str2num(cell2mat(deT(3)));

% 获取数字摘要
hash = GetMD5(TString,'Array','hex'); 

% 生成签名/认证 
int32EncodeSignature = Sign(Modulus, PrivateExponent, hash);
Signature = num2str(int32EncodeSignature);
fprintf('Signature:%s\n',Signature);
fprintf('char:%s\n', char(int32EncodeSignature));







