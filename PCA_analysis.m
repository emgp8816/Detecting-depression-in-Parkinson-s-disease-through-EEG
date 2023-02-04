clear,clc,close all
%% Obtener la matriz con valores a de 2 grupos distintos (10 señales de cada grupo)
length=54;
lpc_length=7;
addpath 'C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project'

% Class 1
X11=zeros(length,lpc_length);
vec11=zeros(length,2);
load(uigetfile('C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\DEP0*'))

for i=1:length
    X11(i,:)=preProcessingfunct(i,EEG);
    vec11(i,1)=1;
end

X12=zeros(length,lpc_length);
vec12=zeros(length,2);
load(uigetfile('C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\DEP0*'))

for i=1:length
    X12(i,:)=preProcessingfunct(i,EEG);
    vec12(i,1)=1;
end


% Class 2

X21=zeros(length,lpc_length);
vec21=zeros(length,2);
load(uigetfile('C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\PD*'))

for i=1:length
    X21(i+length,:)=preProcessingfunct(i,EEG);
    vec21(i+length,2)=1;
end

X22=zeros(length,lpc_length);
vec22=zeros(length,2);
load(uigetfile('C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\PD*'))

for i=1:length
    X22(i+length,:)=preProcessingfunct(i,EEG);
    vec22(i+length,2)=1;
end

X=[X11;X12;X21;X22]';

vec=[vec11;vec12;vec21;vec22]';
y=vec2ind(vec);

% m=4; % number of principal components to calculate
[coeffs,score,latent,tsquared,explained]=pca(X,'NumComponents',4); %Calculates m number of principal components
figure();
scatter(score(:,1),score(:,2),20,y,'filled')
xlabel('Principal component 1')
ylabel('Principal component 2')
colormap(jet)
figure();
scatter3(score(:,1),score(:,2),score(:,3),20,y,'filled')
xlabel('Principal component 1')
ylabel('Principal component 2')
zlabel('Principal component 3')
colormap(jet);
