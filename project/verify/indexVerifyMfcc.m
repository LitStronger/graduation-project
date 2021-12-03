function isVerified = indexVerify(S, Fs,Signature,Modulus, PublicExponent)

% ��֤�� 
strSignature = Signature;
int32Signature = str2num(strSignature);

s=S(1:length(S)); %˫��������

sIndex = 1;
for s_i = 1:length(s) 
    if(abs(s(s_i))>= 0.05)
        tem_s(sIndex) = s(s_i);
        sIndex = sIndex+1;
    end
end
s = tem_s;
%s = awgn(s,100,'measured'); % ����

% ���źŷָ�� x * 4096 �ľ���ÿһ�м�Ϊһ�γ���Ϊ4096���ź�Ƭ�Σ�����ھ���tem��
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
    mfccs = getMfcc(t,Fs);
    [mfccs_r,mfccs_c] = size(mfccs);    % ��ȡ��r����c
    for r = 1:mfccs_r        % ����forѭ��Ƕ��
       for c = 1:mfccs_c
            if(isnan(mfccs(r,c)))
                mfccs(r,c) = 0;     % ��ȡ����ÿ��λ�����ݣ����к���
            end
       end
    end
    mfccs = mfccs(:); % ��άתһά
    E(i) = mean(mfccs); % ƽ��ֵ
    SD(i) = std(mfccs); % ��׼��
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

hash = GetMD5(TString,'Array','hex'); % ��ȡ����ժҪ
isVerified = Verify(Modulus, PublicExponent, hash, int32Signature);
%fprintf('%s\n', hash);
fprintf('Is Verified:%d\n', isVerified);
end