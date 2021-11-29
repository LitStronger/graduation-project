[S, Fs]=audioread('../audio-ditong.aac'); % Fs 采样率 48000
                  % audioread函数读取音频文件（X--保存音频信号的数据；Fs--音频采样率）
s=S(1:length(S)); %如果是双声道则合并

% load noissin.mat; %系统数据测试
% [C,L] = wavedec(noissin,3,'db4');%用db4小波函数进行3层分解

[C,L] = wavedec(s,3,'db3');%用db4小波函数进行3层分解
[cd1,cd2,cd3]=detcoef(C,L,[1,2,3]);%提取第三层的细节分量（高频部分)
ca3=appcoef(C,L,'db3',3);%提取第三层的近似分量（低频部分）
figure;
subplot(511);
plot(s);
ylabel('s');
subplot(512);
plot(1:L(1),ca3);
ylabel('ca3');
subplot(513);
plot(1:L(2),cd3);
ylabel('cd3');
subplot(514);
plot(1:L(3),cd2);
ylabel('cd2');
subplot(515);
plot(1:L(4),cd1);
ylabel('cd1');
set(gcf,'position',[30,30,600,500]);
