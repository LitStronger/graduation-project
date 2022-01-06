addpath ../encode;
addpath ../verify;
addpath ../encode/mfcc;
addpath ../lowPass;

sum = 54; %��Ƶ������
numOfAlarm = 0;
numOfNotAlarm = 0;
rateOfAlarm = 0;
rateOfNotAlarm = 0;
for i=1:sum
   nameIndex = num2str(i);
   if(length(nameIndex)==1)
    nameIndex = ['0',nameIndex];
   end

%   Fs ԭ��Ƶ
   [S1, Fs]=audioread(['../assets/test_assets/raw/audio_test1_Sub_',nameIndex,'.aac']); 
   
%  Fs ����֤��Ƶ

%    ԭ��Ƶ 
%    [S1, Fs]=audioread(['../assets/test_assets/raw/audio_test1_Sub_',nameIndex,'.aac']); 

%    �۸ĺ���Ƶ
%    2.5%
   [S2, Fs]=audioread(['../assets/test_assets/tamper_2.5%/audio_test1_Sub_',nameIndex,'.aac']);   
%    5%
%    [S2, Fs]=audioread(['../assets/test_assets/tamper_5%/audio_test1_Sub_',nameIndex,'_1.aac']); 
%    7.5%
%    [S2, Fs]=audioread(['../assets/test_assets/tamper_7.5%/audio_test1_Sub_',nameIndex,'_1.aac']); 
%    10%
%    [S2, Fs]=audioread(['../assets/test_assets/tamper_10%/audio_test1_Sub_',nameIndex,'_2.aac']); 
%    50%
%    [S2, Fs]=audioread(['../assets/test_assets/tamper_10%/audio_test1_Sub_',nameIndex,'_2.aac']); 
   fprintf('No.%d\t',i);
   
   %    test format&awgn
%    [S1, Fs]=audioread(['../assets/test_assets/raw/audio_test1_Sub_',nameIndex,'.aac']); 
%    [S2, Fs]=audioread(['../assets/test_assets/format/raw/mp3/audio_test1_Sub_',nameIndex,'.mp3']);
%    [S2, Fs]=audioread(['../assets/test_assets/format/raw/wma/audio_test1_Sub_',nameIndex,'.wma']);
%    [S2, Fs]=audioread(['../assets/test_assets/format/raw/wav/audio_test1_Sub_',nameIndex,'.wav']);
%    [S2, Fs]=audioread(['../assets/test_assets/format/raw/m4a/audio_test1_Sub_',nameIndex,'.m4a']);
%    [S2, Fs]=audioread(['../assets/test_assets/awgn/awgn0.01/audio_test1_Sub_',nameIndex,'.ogg']);
   
%    DWT�����ϵ����Ϊ����
   signature = indexGetSignature(S1,1027,749);
   result = indexVerify(S2,signature,1027,5);
   
%    MFCCϵ����Ϊ����
%    signature = indexGetSignatureMfcc(S1,Fs,1027,749);
%    result = indexVerifyMfcc(S2,Fs,signature,1027,5);
   
   if(result == 1) % 1Ϊ��֤�ɹ������澯
    numOfNotAlarm = numOfNotAlarm + 1;
   else
    numOfAlarm = numOfAlarm + 1;
   end
   
   rateOfAlarm = numOfAlarm/sum;
   rateOfNotAlarm = numOfNotAlarm/sum;
end