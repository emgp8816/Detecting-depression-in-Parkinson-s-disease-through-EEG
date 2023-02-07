clear,clc,close all
addpath 'D:\01 Escuela\01 UPIITA\Semestre -2022-2 (8vo)\Procesamiento de Señales\Project\PD_Depression_Project'
info=dir('PD_Depression_Project');
lpc_coeff=154;
Xtra=zeros(115,lpc_coeff);
Xtes=zeros(28,lpc_coeff);
ch=46;
cont1=0;
cont2=0;
for i=3:145
   s=info(i,:);
   s=s.name;
   load(s)
   if i<43 || i>70
       cont1=cont1+1;
       Xtra(cont1,:)=preProcessingfunct(EEG,ch,lpc_coeff);
   else
       cont2=cont2+1;
       Xtes=preProcessingfunct(EEG,ch,lpc_coeff);
   end
end
