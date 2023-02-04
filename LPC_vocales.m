%Reconocimiento de Vocales

seg = 2;

frec = 10000;

tam = frec*seg;

recObj = audiorecorder (frec, 16, 1); %8000Hz, 16 bits, canal 1

disp('grabando audio...')%mensaje de aviso de grabación

recordblocking(recObj,seg);%duración de la funcion de grabación

Y = getaudiodata(recObj);%audio en bruto

figure(1)

plot(Y);%gráfica del audio de entrada

sound(Y,frec);

disp('Reproduciendo audio...')



%reducimos la amplitud de ruidos ajenos al principal con la ventana hamming

%aplicada a cada punto de la señal (proximamente sólo de silencio a silencio)

reduced = Y.*hamming(tam);



%hacemos transf fourier

ft_f=fftshift(fft(reduced));

nfft = tam; %tamaño de la señal en dominio del tiempo





nfft2 = 2^nextpow2(nfft); % tamaño de la señal en potencia de 2

ff = fft(reduced,nfft2);%para limitar a valores positivos la respuesta en frecuencia

fff=ff(1:nfft2/2);

xfft=frec*(0:nfft2/2-1)/nfft2; %se necesita que las muestras en x sean igual a muestras en y



%lpc (predicción lineal) para la respuesta en frecuencias

preemph = [1 0.63]; x1 = filter(1,preemph,reduced);

A = lpc(x1,12); rts = roots(A);

rts = rts(imag(rts)>=0); 

angz = atan2(imag(rts),real(rts));

[frqs,indices] = sort(angz.*(frec/(2*pi))); 

bw = -1/2*(frec/(2*pi))*log(abs(rts(indices)));

nn = 1; 

for kk = 1:length(frqs)

    if (frqs(kk) > 90 && bw(kk) <400)

        formants(nn) = frqs(kk);

        nn = nn+1;

    end

end

formants;



%figure(3)

%plot(xfft, abs(fff));%para normalizar a uno, dividir fff entre max(fff)

%plot(xfft,abs(fff)) 

%orden : vocal,a,e,i,o,u







%ESPECTROGRAMA

segmentlen = 100; 

noverlap = 90; 

NFFT = 128;

figure(4)

spectrogram(Y,segmentlen,noverlap,NFFT,frec,'yaxis') 

title('Espectrograma de la Señal')



%predicción

va =[1000,1400];

ve =[500,2300];

vi =[320,2700];

vo =[404,743];

vu =[277,544];



vocal =[formants(1),formants(2)]

vocalx = [formants(1),va(1),ve(1),vi(1),vo(1),vu(1)];

vocaly = [formants(2),va(2),ve(2),vi(2),vo(2),vu(2)];



figure(5)

scatter(vocalx,vocaly,20);grid;



dista = norm(va-vocal);

diste = norm(ve-vocal);

disti = norm(vi-vocal);

disto = norm(vo-vocal);

distu = norm(vu-vocal);



aux = [dista,diste,disti,disto,distu];



pred = min(aux)



switch pred

    case dista

        disp('La vocal es a')

    case diste

        disp('La vocal es e')

    case disti

        disp('La vocal es i')

    case disto

        disp('La vocal es o')

    case distu

        disp('La vocal es u')

end