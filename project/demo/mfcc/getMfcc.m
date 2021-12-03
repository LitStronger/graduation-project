function MFCCs = getMfcc(speech,fs)    
    % Define variables
    Tw = 25;                % analysis frame duration (ms)
    Ts = 10;                % analysis frame shift (ms)
    alpha = 0.97;           % preemphasis coefficient
    M = 20;                 % number of filterbank channels 
    C = 12;                 % number of cepstral coefficients
    L = 22;                 % cepstral sine lifter parameter
    LF = 300;               % lower frequency limit (Hz)
    HF = 3700;              % upper frequency limit (Hz)
    %wav_file = 'sp10.wav';  % input audio filename

    % Read speech samples, sampling rate and precision from file    
    %[ speech, fs ] = audioread( wav_file );
    %speech =speech(1:length(speech)); % 双声道处理；拼接，二维转一维
    
    % Feature extraction (feature vectors as columns)
    [ MFCCs, FBEs, frames ] = ...
                    mfcc( speech, fs, Tw, Ts, alpha, @hamming, [LF HF], M, C+1, L );
end
