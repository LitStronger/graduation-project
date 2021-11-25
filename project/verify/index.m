% ģ�빫Կ
Modulus = 3901;
PublicExponent = 3; 

% ��֤�� 
strSignature = '1102   964  3009  1102  3752  3173  2225   157  2885  3752  2885  3173  3173  2225  3611  3611  2885  2225  2225  2885  3741  3752  1102  3308   537   157  2570  2885   157   921   921  3308';
int32Signature = str2num(strSignature);

%[S, Fs]=audioread('../assets/audio-raw.aac'); % Fs ԭ��Ƶ
%[S, Fs]=audioread('../assets/audio-ditong.aac'); % Fs ��ͨ����
%[S, Fs]=audioread('../assets/audio-revert.aac'); % Fs Ƭ�ε�װ���� 
%[S, Fs]=audioread('../assets/audio-noise.aac'); % Fs ���봦��
%[S, Fs]=audioread('../assets/audio-resample_44.1khz.aac'); % Fs �ز�������

s=S(1:length(S)); %�����˫������ϲ�

% ���źŷָ�� x * 8192 �ľ���ÿһ�м�Ϊһ�γ���Ϊ8192���ź�Ƭ�Σ�����ھ���tem��
sum = 1;
x = 1;
len = 8192; % �ֶγ���
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
    t = sprintf('%8.1f',T(i)); %��T�е�����ȫ������Ϊ8λ�ַ���
    TString = strcat(TString,t); 
end
for i = length(T)/2+1:length(T)
    t = sprintf('%8.1f',T(i)); %��T�е�����ȫ������Ϊ8λ�ַ���
    TString = strcat(TString,t); 
end

% deT = strsplit(TString);
% data = str2num(cell2mat(deT(3)));

hash = GetMD5(TString,'Array','hex'); % ��ȡ����ժҪ

IsVerified = Verify(Modulus, PublicExponent, hash, int32Signature);
fprintf('Is Verified:%d\n', IsVerified)








