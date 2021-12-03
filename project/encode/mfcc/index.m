Modulus = 1027;
PrivateExponent = 749;

[S, Fs]=audioread('../../assets/test_assets/raw/audio_test1_Sub_01.aac'); % Fs ԭ��Ƶ
%[S, Fs]=audioread('../../assets/test_assets/tamper_2.5%/audio_test1_Sub_01.aac');


s=S(1:length(S)); %�����˫������ϲ�

% 0�źŴ���
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
%s = awgn(s,40,'measured'); % ����
%plot(s);

% ���źŷָ�� x * 4096 �ľ���ÿһ�м�Ϊһ�γ���Ϊ4096���ź�Ƭ�Σ�����ھ���tem��
sum = 1;
x = 1;
len = 4096; % �ֶγ���
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

%��ÿ��Ƭ�ζ�mfcc��ȡ�����ϵ������ֵ��ƽ��ֵ
i = 1;
while i<=sLen
    t = tem(i,:); % ȡ��i��
    %plot(tem(1,:));
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
   % mfccs = abs(mfccs);
    E(i) = mean(mfccs); % ƽ��ֵ
    SD(i) = std(mfccs); % ��׼��
    i=i+1;
end

T = [E,SD]; % ƴ��һά����E��SD���õ�һά����T
TString = '';
for i = 1:length(T)/2
    t = sprintf('%8.2f',T(i)); %��T�е�����ȫ������Ϊ8λ�ַ���������������λ��С���������λ
    TString = strcat(TString,t); 
end
for i = length(T)/2+1:length(T)
    t = sprintf('%8.2f',T(i)); %��T�е�����ȫ������Ϊ8λ�ַ���������������λ��С���������λ
    TString = strcat(TString,t); 
end

% ��ȡ����ժҪ
%hash = GetMD5(TString,'Array','hex'); 

% ����ǩ��/��֤ 
%int32EncodeSignature = Sign(Modulus, PrivateExponent, hash);
%Signature = num2str(int32EncodeSignature);

