
close all
clear all
    
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

for banda=1:8
    
    %limpio las variables que hacen resize
    clear Rho1;
    clear Phi1;
    clear EjeX1;
    clear EjeF1;
    
    clear Rho2;
    clear Phi2;
    clear EjeX2;
    clear EjeF2;
    

    if(banda==1) %delta
        frec='delta';
        FRANGE=[1:0.2:3];
    elseif(banda==2) %theta
         frec='theta';
        FRANGE=[4:0.2:8];
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
    elseif(banda==4) %beta
        frec='beta';
        FRANGE=[12:1:35];
    elseif(banda==5) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
    elseif(banda==6) %beta2
         frec='beta2';
        FRANGE=[22:0.5:35];
    elseif(banda==7) %total
         frec='total';
        FRANGE=[1:1:35];
    elseif(banda==8) %totalCut
        frec='totalCut';
        FRANGE=[4:1:35];   %saco delta
    end   

    FE=256;
    %WinSig=256;
    %step=WinSig-WinSig/2;
    %WinSig=FE/16;
    WinSig=20;
    step=WinSig-WinSig/2;
    
    %sumo los sujetos
    
    %%

for i=1:4 %condiciones
    for j=1:20 %sujetos
        suj=load(['D:\EEG\priming48hs\estructuras\cond_',num2str(i),'\s',num2str(j),'.mat']);
        sujP= mean(suj.datos,3); %promedio en epocas
        sujDatosTot(:,:,j)=sujP;
        sujTimesTot(:,:,j)=suj.times;
    end
    sujDatosPmedio=squeeze(mean(sujDatosTot,3));     %hago promedio en sujetos
    sujTimesPmedio=squeeze(mean(sujTimesTot,3));     
    
    sujDatosTotCond(:,:,i)=sujDatosPmedio;       %guardo el promedio en la conndicion
    sujTimesTotCond(:,:,i)=sujTimesPmedio;
end

%sujDatosPmedioCond=squeeze(mean(sujDatosTotCond,3)); %promedio en condiciones
%sujTimesPmedioCond=squeeze(mean(sujTimesTotCond,3)); %promedio en condiciones
    
%% Hago la fft

    for i=1:4
        %para antes
        ind1=[1:51];
        TRANGE1=[0:sujTimesTotCond(ind1(1))*(-1)]; %porque los primeros 51 numeros estan en negativo (los anteriores)
        %para despues
        ind2=[52:307];
        TRANGE2=[0:sujTimesTotCond(ind2(end))];

        %para tiempos antes
        SIG1=sujDatosTotCond(:,1:51,i);
        [Rho1, Phi1, EjeX1, EjeF1] = espectrograma2( SIG1, FE, FRANGE, TRANGE1, WinSig, step);
        save(['D:\EEG\priming48hs\fft\ERPtotSujCond\cond_',num2str(i),'\',frec,'\t1\sujPmedio.mat'],'Rho1','Phi1','EjeX1','EjeF1');

        %para tiempos despues
        SIG2=sujDatosTotCond(:,51:307,i);
        [Rho2, Phi2, EjeX2, EjeF2] = espectrograma2( SIG2, FE, FRANGE, TRANGE2, WinSig, step);
        save(['D:\EEG\priming48hs\fft\ERPtotSujCond\cond_',num2str(i),'\',frec,'\t2\sujPmedio.mat'],'Rho2','Phi2','EjeX2','EjeF2');

    end
end



