 [S, Fs]=audioread('../assets/audio.aac');s=S(1:length(S));   % Fs ������ 48000
                  % audioread������ȡ��Ƶ�ļ���X--������Ƶ�źŵ����ݣ�Fs--��Ƶ�����ʣ�
wavename='db4'; % ѡ��С����                
totalscal=128;
wcf=centfrq(wavename); % С��������Ƶ��  ���Fc = 3
cparam=2*wcf*totalscal;    % ���c = 1536
scal=cparam./(1:totalscal);   % ��ó߶�
f=scal2frq(scal,wavename,1/Fs); % ���߶�ת��ΪƵ��   % Ƶ����0-500Hzȡ1024����
coefs = cwt(s,scal,wavename); % ������С��ϵ��
t=(0:length(s)-1)/Fs;
colorbar;
mesh(t,f,abs(coefs));
axis tight;   
xlabel('ʱ�� t/s');
ylabel('Ƶ�� f/Hz');
zlabel('����');
title('С��ʱƵͼ');