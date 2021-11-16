[S, Fs]=audioread('../audio-ditong.aac'); % Fs ������ 48000
                  % audioread������ȡ��Ƶ�ļ���X--������Ƶ�źŵ����ݣ�Fs--��Ƶ�����ʣ�
s=S(1:length(S)); %�����˫������ϲ�

% load noissin.mat; %ϵͳ���ݲ���
% [C,L] = wavedec(noissin,3,'db4');%��db4С����������3��ֽ�

[C,L] = wavedec(s,3,'db3');%��db4С����������3��ֽ�
[cd1,cd2,cd3]=detcoef(C,L,[1,2,3]);%��ȡ�������ϸ�ڷ�������Ƶ����)
ca3=appcoef(C,L,'db3',3);%��ȡ������Ľ��Ʒ�������Ƶ���֣�
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
