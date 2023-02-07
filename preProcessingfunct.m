function [a] = preProcessingfunct(EEG,ch,lpc_coeff)
%% Normalization and offset correction
signal = EEG.data(ch,:)';
% EEG_detrend=detrend(EEG);                             %Eliminate offset
% EEG_normalized=EEG_detrend/max(abs(EEG_detrend));     %Normalize

EEG_normalized=(signal-mean(signal))/std(signal);
%% LOW PASS FILTER - 100 Hz
Fs=500;
fc_hp=100;

[B,A] = butter(2,fc_hp/(Fs/2));
EEG_filt=filter(B,A,EEG_normalized);
EEG_filt=filter(B,A,EEG_filt);          %Two 2nd order butterworth filter = 4th order Butterworth Filter

%% 60 HZ - FILTER
fc_sb=[59 61];

[B,A] = ellip(3,1,20,fc_sb/(Fs/2),'stop');
EEG_filt2=filter(B,A,EEG_filt);

%% Power Spectral Density with parametric methods
EEG_powSpec=pwelch(EEG_filt2,[],[],[],Fs);   
EEG_powSpec=EEG_powSpec(1:Fs/2);

%% LPC 
a = lpc(double(EEG_powSpec),lpc_coeff);
%mean(a)
a=a(2:end);
%a=a-mean(a);
% a=abs(a)/max(abs(a));
end