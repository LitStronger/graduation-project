Modulus = 1027;
PrivateExponent = 749;

[S, Fs]=audioread('../../assets/test_assets/raw/audio_test1_Sub_01.aac'); % Fs 原音频
%[S, Fs]=audioread('../../assets/test_assets/tamper_2.5%/audio_test1_Sub_01.aac');


s=S(1:length(S)); %如果是双声道则合并

% 0信号处理
%for sIndex = 1:length(s) 
%    if(abs(s(sIndex))<= 0.001)
%        if(s(sIndex) > 0)
%            s(sIndex) = eps;
%        else
%            s(sIndex) = -eps;
%        end
%    end
%end
sIndex = 1;
for s_i = 1:length(s) 
    if(abs(s(s_i))>= 0.05)
        tem_s(sIndex) = s(s_i);
        sIndex = sIndex+1;
    end
end
s = tem_s;
%s = awgn(s,40,'measured'); % 加噪
%plot(s);

% 将信号分割成 x * 4096 的矩阵，每一行即为一段长度为4096的信号片段，存放在矩阵tem中
sum = 1;
x = 1;
len = 4096; % 分段长度
sLen = (length(s)/len)+1;
while x<=sLen 
    for y=1:len               
        if(sum<length(s))
            tem(x, y) = s(1,sum);
            %if(abs(s(1,sum)) <= 0.001)
            %    tem(x,y) =  0.001;
            %else
            %    tem(x, y) = s(1,sum);
            %end
        else
            tem(x,y) = eps;
        end
        sum=sum+1;
    end
    x = x+1;
end

%对每个片段都mfcc，取其近似系数绝对值的平均值
i = 1;
while i<=sLen
    t = tem(i,:); % 取第i行
    %plot(tem(1,:));
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
   % mfccs = abs(mfccs);
    E(i) = mean(mfccs); % 平均值
    SD(i) = std(mfccs); % 标准差
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

% 获取数字摘要
%hash = GetMD5(TString,'Array','hex'); 

% 生成签名/认证 
%int32EncodeSignature = Sign(Modulus, PrivateExponent, hash);
%Signature = num2str(int32EncodeSignature);

