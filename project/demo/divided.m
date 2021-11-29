[S, Fs]=audioread('sample.m4a'); % Fs 采样率 48000
                  % audioread函数读取音频文件（X--保存音频信号的数据；Fs--音频采样率）
s=S(1:length(S)); %如果是双声道则合并

sum = 1;
x = 1;
len = 2048; % 分段长度
l = length(s)
while (length(s)/len)+1 >= x  % 将信号分割成 x * 2048的矩阵，每一行即为一段长度为2048的信号片段
    for y=1:len               % 存放在矩阵tem中
        if(sum<length(s))
            tem(x, y) = s(1,sum);
        else
            tem(x,y) = 0;
        end
        sum=sum+1;
    end
    x = x+1;
end