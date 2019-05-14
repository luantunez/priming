
close all
clear all
    
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%for banda=1:8

banda=8;
    
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

    for i=1:4 %condiciones
        for j=1:22 %sujetos
            suj=load(['D:\EEG\priming\estructuras\cond_',num2str(i),'\s',num2str(j),'.mat']);
            %para antes
            ind1=[1:51];
            TRANGE1=[0:suj.times(ind1(1))*(-1)]; %porque los primeros 51 numeros estan en negativo (los anteriores)
            %para despues
            ind2=[52:307];
            TRANGE2=[0:suj.times(ind2(end))];
            for k=1:size(suj.datos,3) %epocas
                %para tiempos antes
                SIG1=suj.datos(:,1:51,k);
                [Rho1(:,:,:,k), Phi1(:,:,:,k), EjeX1(:,:,k), EjeF1(:,:,k)] = espectrograma2( SIG1, FE, FRANGE, TRANGE1, WinSig, step);
                %RhoP1=squeeze(Rho1);
                %suj(j)=RhoP1;
                save(['D:\EEG\priming\fft\cond_',num2str(i),'\',frec,'\t1\s',num2str(j),'.mat'],'Rho1','Phi1','EjeX1','EjeF1');
                %para tiempos despues
                SIG2=suj.datos(:,51:307,k);
                [Rho2(:,:,:,k), Phi2(:,:,:,k), EjeX2(:,:,k), EjeF2(:,:,k)] = espectrograma2( SIG2, FE, FRANGE, TRANGE2, WinSig, step);
               save(['D:\EEG\priming\fft\cond_',num2str(i),'\',frec,'\t2\s',num2str(j),'.mat'],'Rho2','Phi2','EjeX2','EjeF2');
                %RhoP2=squeeze(Rho2);
                %suj(j)=RhoP2;
            end
        end
    end

%end

%% graficos

% EjeX=mean(EjeX1,3);
% EjeX=squeeze(EjeX(:,:,1));
% 
% EjeF=mean(EjeF1,3);
% EjeF=squeeze(EjeF(:,:,1));
% 
% Rho=mean(Rho1,4);
% Rho=squeeze(Rho);
% RhoP=mean(Rho,1);
% RhoP=squeeze(RhoP);
% 
% imagesc(EjeX,EjeF,RhoP',[-1 15]);
% xlabel('tiempo');
% ylabel('frecuencia'); 
% title('baseline');
% figure();
% 
% EjeX=squeeze(EjeX2(:,:,1));
% EjeF=squeeze(EjeF2(:,:,1));
% Rho=squeeze(Rho2(:,:,:,1));
% RhoP=mean(Rho,1);
% RhoP=squeeze(RhoP);
% 
% imagesc(EjeX,EjeF,RhoP',[-1 25]);
% xlabel('tiempo');
% title('testeo');
% ylabel('frecuencia'); 