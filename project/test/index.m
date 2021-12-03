addpath ../encode;
addpath ../verify;
addpath ../encode/mfcc;
sum = 54; %音频总数量
numOfSuccess = 0;
numOfFail = 0;
rateOfSuccess = 0;
rateOfFail = 0;
for i=1:sum
   nameIndex = num2str(i);
   if(length(nameIndex)==1)
    nameIndex = ['0',nameIndex];
   end
   
   % Fs 原音频
   [S1, Fs]=audioread(['../assets/test_assets/raw/audio_test1_Sub_',nameIndex,'.aac']); 
   % Fs 待认证音频
   % 加噪
   %S2 = awgn(S1,100,'measured');
   %S2 = S1; 
   
   % 2.5%
   [S2, Fs]=audioread(['../assets/test_assets/tamper_2.5%/audio_test1_Sub_',nameIndex,'.aac']); 
  
   % 5%
   %[S2, Fs]=audioread(['../assets/test_assets/tamper_5%/audio_test1_Sub_',nameIndex,'_1.aac']); 
   
   % 7.5%
   %[S2, Fs]=audioread(['../assets/test_assets/tamper_7.5%/audio_test1_Sub_',nameIndex,'_1.aac']); 
   
   % 10%
   %[S2, Fs]=audioread(['../assets/test_assets/tamper_10%/audio_test1_Sub_',nameIndex,'_2.aac']); 
   fprintf('No.%d\t',i);
   
   % 三层小波变近似系数作为特征
   signature = indexGetSignature(S1,1027,749);
   isVerified = indexVerify(S2,signature,1027,5);
   
   % mfcc系数作为特征
   %signature = indexGetSignatureMfcc(S1,Fs,1027,749);
   %isVerified = indexVerifyMfcc(S2,Fs,signature,1027,5);
   
   if(isVerified == 1)
    numOfSuccess = numOfSuccess + 1;
   else
    numOfFail = numOfFail + 1;
   end
   
   rateOfSuccess = numOfSuccess/sum;
   rateOfFail = numOfFail/sum;
end