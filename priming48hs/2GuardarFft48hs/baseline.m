close all
clear all
    
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');



banda=7;

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
end   

for i=1:4 %condiciones    
    for j=1:22 %sujetos
        suj=load(['D:\EEG\priming\fft\cond_',num2str(i),'\',frec,'\t1\s',num2str(j),'.mat']);
        Rho1=suj.Rho1;
        RhoP1=mean(Rho1,2); %hago promedio de tiempos en Rho
        Phi1=suj.Phi1;
        PhiP1=mean(Phi1,2); %hago promedio de tiempos en Phi
        EjeX1=suj.EjeX1; %lo tomo para volver a guardarlo
        EjeF1=suj.EjeF1;    %lo tomo para volver a guardarlo
        %save(['D:\EEG\priming\fft\cond_',num2str(i),'\',frec,'\t1Pmedio\s',num2str(j),'.mat'],'RhoP1','PhiP1','EjeX1','EjeF1');
    end
end

%%
EjeX=mean(EjeX1,3);
EjeX=squeeze(EjeX(:,:,1));

EjeF=mean(EjeF1,3);
EjeF=squeeze(EjeF(:,:,1));

Rho=mean(RhoP1,4);
Rho=squeeze(Rho);
RhoP=mean(Rho,1);
RhoP=squeeze(RhoP);

imagesc(EjeX,EjeF,RhoP',[-1 15]);
xlabel('tiempo');
ylabel('frecuencia'); 
title('baseline');
figure();

%%
EjeX=squeeze(EjeX2(:,:,1));
EjeF=squeeze(EjeF2(:,:,1));
Rho=squeeze(Rho2(:,:,:,1));
RhoP=mean(Rho,1);
RhoP=squeeze(RhoP);

imagesc(EjeX,EjeF,RhoP',[-1 25]);
xlabel('tiempo');
title('testeo');
ylabel('frecuencia'); 

for t=1:size(Ejex1,2)
    Rho1(:,t,:,:)./RhoP1(:,:,:,:);
end