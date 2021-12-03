 [S, Fs]=audioread('../assets/audio.aac');s=S(1:length(S));   % Fs 采样率 48000
                  % audioread函数读取音频文件（X--保存音频信号的数据；Fs--音频采样率）
wavename='db4'; % 选定小波基                
totalscal=128;
wcf=centfrq(wavename); % 小波的中心频率  测得Fc = 3
cparam=2*wcf*totalscal;    % 测得c = 1536
scal=cparam./(1:totalscal);   % 求得尺度
f=scal2frq(scal,wavename,1/Fs); % 将尺度转换为频率   % 频率在0-500Hz取1024个点
coefs = cwt(s,scal,wavename); % 求连续小波系数
t=(0:length(s)-1)/Fs;
colorbar;
mesh(t,f,abs(coefs));
axis tight;   
xlabel('时间 t/s');
ylabel('频率 f/Hz');
zlabel('幅度');
title('小波时频图');