function isVerified = indexVerify(S,Signature,Modulus, PublicExponent)
addpath ../lowPass;

% ��֤�� 
strSignature = Signature;
int32Signature = str2num(strSignature);

s=S(1:length(S)); %�����˫������ϲ�

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

% ���źŷָ�� x * 8192 �ľ���ÿһ�м�Ϊһ�γ���Ϊ8192���ź�Ƭ�Σ�����ھ���tem��
sum = 1;
x = 1;
len = 4096; % �ֶγ���
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

%��ÿ��Ƭ�ζ�������С���ֽ⣬ȡ�����ϵ������ֵ��ƽ��ֵ
i = 1;
while i<=sLen
    t = tem(i,:); % ȡ��i��
    [C,L] = wavedec(t,3,'db1');% ��db3С����������3��ֽ�
    [cd1,cd2,cd3]=detcoef(C,L,[1,2,3]);%��ȡ�������ϸ�ڷ�������Ƶ����)
    ca3= abs(appcoef(C,L,'db1',3));%��ȡ������Ľ��Ʒ�������Ƶ���֣�,��ȡ�����ֵ
    E(i) = mean(ca3); % ����ֵ��ƽ��ֵ
    SD(i) = std(ca3); % ��׼��
    %E2 = sprintf('%8.3f',E1); %
    i=i+1;
end

T = [E,SD]; % ƴ��һά����E��SD���õ�һά����T
TString = '';
for i = 1:length(T)/2
    t = sprintf('%8.2f',T(i)); %��T�е�����ȫ������Ϊ8λ�ַ���
    TString = strcat(TString,t); 
end
for i = length(T)/2+1:length(T)
    t = sprintf('%8.2f',T(i)); %��T�е�����ȫ������Ϊ8λ�ַ���
    TString = strcat(TString,t); 
end

fprintf('\nTString:%s\n',TString);

hash = GetMD5(TString,'Array','hex'); % ��ȡ����ժҪ
isVerified = Verify(Modulus, PublicExponent, hash, int32Signature);
fprintf('hash2:%s', hash);
fprintf('\nIs Verified:%d\n', isVerified);
end