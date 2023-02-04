clear,clc,close all
addpath 'C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project'
length=18;
lpc_coeff=7;
%% CH:CP3
ch=36;

% Class 1
X1=zeros(length,lpc_coeff);
vec1=zeros(length,2);

for i=1:length
    if i<=10
        load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\Control10',num2str(i-1),'1_Preprocessed.mat'])
    else
        load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\Control1',num2str(i-1),'1_Preprocessed.mat'])
    end
    X1(i,:)=preProcessingfunct(EEG,ch,lpc_coeff);
    vec1(i,1)=1;
end

% Class 2

X2=zeros(length,lpc_coeff);
vec2=zeros(length,2);

for i=1:length
    if i<=10
        load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\PD10',num2str(i-1),'1_Preprocessed.mat'])
    else
    load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\PD1',num2str(i-1),'1_Preprocessed.mat'])
    end    
    X2(i,:)=preProcessingfunct(EEG,ch,lpc_coeff);
    vec2(i,2)=1;
end

X=[X1;X2];
vec=[vec1;vec2]';

% X=X(:,1:numCoeff);

y=vec2ind(vec);

% m=4; % number of principal components to calculate
[coeffs1,score1,latent1,tsquared1,explained1]=pca(X); %Calculates m number of principal components
figure();
scatter(score1(:,1),score1(:,2),20,y,'filled')
title('PCA analysis for PDDEP vs. PD - Ch. CP3')
xlabel('Principal component 1')
ylabel('Principal component 2')
colormap(jet)
figure();
scatter3(score1(:,1),score1(:,2),score1(:,3),20,y,'filled')
title('PCA analysis for PDDEP vs. PD - Ch. CP3')
xlabel('Principal component 1')
ylabel('Principal component 2')
zlabel('Principal component 3')
colormap(jet);

%% CH:TP8
ch=46;

% Class 1
X1=zeros(length,lpc_coeff);
vec1=zeros(length,2);

for i=1:length
    if i<=10
        load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\Control10',num2str(i-1),'1_Preprocessed.mat'])
    else
        load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\Control1',num2str(i-1),'1_Preprocessed.mat'])
    end
    X1(i,:)=preProcessingfunct(EEG,ch,lpc_coeff);
    vec1(i,1)=1;
end

% Class 2

X2=zeros(length,lpc_coeff);
vec2=zeros(length,2);

for i=1:length
    if i<=10
        load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\PD10',num2str(i-1),'1_Preprocessed.mat'])
    else
    load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\PD1',num2str(i-1),'1_Preprocessed.mat'])
    end    
    X2(i,:)=preProcessingfunct(EEG,ch,lpc_coeff);
    vec2(i,2)=1;
end

X=[X1;X2];
vec=[vec1;vec2]';

% X=X(:,1:numCoeff);

y=vec2ind(vec);

% m=4; % number of principal components to calculate
[coeffs2,score2,latent2,tsquared2,explained2]=pca(X); %Calculates m number of principal components
figure();
scatter(score2(:,1),score2(:,2),20,y,'filled')
title('PCA analysis for PDDEP vs. PD - Ch. TP8')
xlabel('Principal component 1')
ylabel('Principal component 2')
colormap(jet)
figure();
scatter3(score2(:,1),score2(:,2),score2(:,3),20,y,'filled')
title('PCA analysis for PDDEP vs. PD - Ch. TP8')
xlabel('Principal component 1')
ylabel('Principal component 2')
zlabel('Principal component 3')
colormap(jet);

%% CH:CP3+TP8

ch=[36 46];

% Class 1
X1=zeros(length,lpc_coeff);
vec1=zeros(length,2);

for i=1:length
    if i<=10
        load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\Control10',num2str(i-1),'1_Preprocessed.mat'])
    else
        load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\Control1',num2str(i-1),'1_Preprocessed.mat'])
    end
    X1(i,:)=preProcessingfunct2ch(EEG,ch,lpc_coeff);
    vec1(i,1)=1;
end

% Class 2

X2=zeros(length,lpc_coeff);
vec2=zeros(length,2);

for i=1:length
    if i<=10
        load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\PD10',num2str(i-1),'1_Preprocessed.mat'])
    else
    load(['C:\Users\Joeli\Dropbox\mCodes\PD_Depression_Project\PD1',num2str(i-1),'1_Preprocessed.mat'])
    end    
    X2(i,:)=preProcessingfunct2ch(EEG,ch,lpc_coeff);
    vec2(i,2)=1;
end

X=[X1;X2];
vec=[vec1;vec2]';

% X=X(:,1:numCoeff);

y=vec2ind(vec);

% m=4; % number of principal components to calculate
[coeffs3,score3,latent3,tsquared3,explained3]=pca(X); %Calculates m number of principal components
figure();
scatter(score3(:,1),score3(:,2),20,y,'filled')
title('PCA analysis for PDDEP vs. PD - Ch. CP3+TP8')
xlabel('Principal component 1')
ylabel('Principal component 2')
colormap(jet)
figure();
scatter3(score3(:,1),score3(:,2),score3(:,3),20,y,'filled')
title('PCA analysis for PDDEP vs. PD - Ch. CP3+TP8')
xlabel('Principal component 1')
ylabel('Principal component 2')
zlabel('Principal component 3')
colormap(jet);