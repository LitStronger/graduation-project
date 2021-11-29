Modulus = 1027;
PrivateExponent = 749;

% audioread������ȡ��Ƶ�ļ���X--������Ƶ�źŵ����ݣ�Fs--��Ƶ�����ʣ�
[S, Fs]=audioread('../assets/test_assets/raw/audio_test1_Sub_01.aac'); % Fs ԭ��Ƶ
%[S, Fs]=audioread('../assets/test_assets/tamper_2.5%/audio_test1_Sub_07.aac'); % Fs �۸���Ƶ

%[S, Fs]=audioread('../assets/audio-ditong.aac'); % Fs ��ͨ����
%[S, Fs]=audioread('../assets/audio-revert.aac'); % Fs Ƭ�ε�װ���� 
%[S, Fs]=audioread('../assets/audio-noise.aac'); % Fs ���봦��
%[S, Fs]=audioread('../assets/audio-resample_44.1khz.aac'); % Fs �ز�������

s=S(1:length(S)); %�����˫������ϲ�

%s=s+normrnd(0,0.005);% ����

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
    t = sprintf('%8.2f',T(i)); %��T�е�����ȫ������Ϊ8λ�ַ���������������λ��С���������λ
    TString = strcat(TString,t); 
end
for i = length(T)/2+1:length(T)
    t = sprintf('%8.2f',T(i)); %��T�е�����ȫ������Ϊ8λ�ַ���������������λ��С���������λ
    TString = strcat(TString,t); 
end

% deT = strsplit(TString);
% data = str2num(cell2mat(deT(3)));

% ��ȡ����ժҪ
hash = GetMD5(TString,'Array','hex'); 

% ����ǩ��/��֤ 
int32EncodeSignature = Sign(Modulus, PrivateExponent, hash);
Signature = num2str(int32EncodeSignature);
fprintf('Signature:%s\n',Signature);
fprintf('char:%s\n', char(int32EncodeSignature));







