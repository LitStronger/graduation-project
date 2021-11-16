%[S, Fs]=audioread('sample-raw.aac'); % Fs ������ 
%[S, Fs]=audioread('sample-ditong.aac'); % Fs ������ 
%[S, Fs]=audioread('sample-cut.aac'); % Fs ������ 
%[S, Fs]=audioread('sample-revert.aac'); % Fs ������ 

%[S, Fs]=audioread('audio.aac'); % Fs ������  
%[S, Fs]=audioread('audio-ditong.aac'); % Fs ������ 
%[S, Fs]=audioread('audio-revert.aac'); % Fs ������ 
[S, Fs]=audioread('audio-noise.aac'); % Fs ������ 

                  % audioread������ȡ��Ƶ�ļ���X--������Ƶ�źŵ����ݣ�Fs--��Ƶ�����ʣ�
s=S(1:length(S)); %�����˫������ϲ�

% ���źŷָ�� x * 2048�ľ���ÿһ�м�Ϊһ�γ���Ϊ8192���ź�Ƭ�Σ�����ھ���tem��
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
    t = sprintf('%8.1f',T(i)); %��T�е�����ȫ������Ϊ8λ�ַ���������������λ��С���������λ
    TString = strcat(TString,t); 
end
for i = length(T)/2+1:length(T)
    t = sprintf('%8.1f',T(i)); %��T�е�����ȫ������Ϊ8λ�ַ���������������λ��С���������λ
    TString = strcat(TString,t); 
end

deT = strsplit(TString);

data = str2num(cell2mat(deT(3)));



