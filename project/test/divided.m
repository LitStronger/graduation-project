[S, Fs]=audioread('sample.m4a'); % Fs ������ 48000
                  % audioread������ȡ��Ƶ�ļ���X--������Ƶ�źŵ����ݣ�Fs--��Ƶ�����ʣ�
s=S(1:length(S)); %�����˫������ϲ�

sum = 1;
x = 1;
len = 2048; % �ֶγ���
l = length(s)
while (length(s)/len)+1 >= x  % ���źŷָ�� x * 2048�ľ���ÿһ�м�Ϊһ�γ���Ϊ2048���ź�Ƭ��
    for y=1:len               % ����ھ���tem��
        if(sum<length(s))
            tem(x, y) = s(1,sum);
        else
            tem(x,y) = 0;
        end
        sum=sum+1;
    end
    x = x+1;
end