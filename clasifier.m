load('Xtra_final.mat')
load('Xtes_final.mat')
datos=Xtra;
car=154;
x=datos(:,1:car);
[n,p]=size(x);
c=zeros(p);
m=mean(datos);
s=std(datos);
for i=1:p
    for j=1:p
        temp=0;
        for k=1:n
            temp=temp+((x(k,i)-m(i))*(x(k,j)-m(j)));
        end
    c(i,j)=temp/(n-1);
    end
end
cinv=inv(c);
C1=datos(1:40,:);
c1=mean(C1)';

C2=datos(41:end,:);
c2=mean(C2)';
z1=c1(1:car,1);
z2=c2(1:car,1);

s='Control1411_Preprocessed.mat';
load(s)
ch1=36;
ch2=46;
lpc_coeff=154;
X1=preProcessingfunct(EEG,ch1,lpc_coeff)';
X2=preProcessingfunct(EEG,ch2,lpc_coeff)';
X=X1+X2;
euc=[(X-z1)'*cinv*(X-z1),(X-z2)'*cinv*(X-z2)];
[val, pos]=min(euc);
         if euc(1)==euc(2) 
             fprintf('Undefined')
         elseif pos==1
             fprintf('Non depression')
         elseif pos==2
             fprintf('Depression')
         end 