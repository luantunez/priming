close all    
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

banda=8;

    if(banda==1) %delta
        frec='delta';
        FRANGE=[1:0.2:3];
        colorBar=[-1.5 1.7];
    elseif(banda==2) %theta
         frec='theta';
        FRANGE=[4:0.2:8];
        colorBar=[-1.8 2.2];
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
        colorBar=[-1.7 2.2]; 
    elseif(banda==4) %beta
        frec='beta';
        FRANGE=[12:1:35];
        colorBar=[-1.5 2];
    elseif(banda==5) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
        colorBar=[-1.7 2.2];
    elseif(banda==6) %beta2
         frec='beta2';
        FRANGE=[22:0.5:35];
        colorBar=[-1.5 2];
    elseif(banda==7) %total
         frec='total';
        FRANGE=[1:1:35];
        %colorBar=[-1.2 1.2];  %t2Norm2
        colorBar=[-1.7 2.1];
    elseif(banda==8) %totalCut
        frec='totalCut';
        FRANGE=[4:1:35];   %saco delta
        colorBar=[-1.7 2.1];
    end  
%%

suj=load(['D:\EEG\priming48hs\fft\ERPtotSuj\',frec,'\t2Norm\sujPmedio.mat']); 
pmedioRhoP2=mean(suj.RhoP2,1);  %promedio de todos los canales para cada sujeto;
pmedioRhoP2=squeeze(pmedioRhoP2);

%% Grafico el promedio

imagesc(suj.EjeX2/1000,suj.EjeF2,pmedioRhoP2',colorBar);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');

[X,Y]   = meshgrid(1:size(pmedioRhoP2,1), 1:length(FRANGE));

[X2,Y2] = meshgrid(1:0.05:size(pmedioRhoP2,1), 1:0.1:length(FRANGE));

 sujFilt = interp2(X, Y, pmedioRhoP2', X2, Y2, 'linear');
 
 figure();
 
 imagesc(suj.EjeX2/1000,suj.EjeF2,sujFilt,colorBar);
 
%ylim([5,30]);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');