figure()
%close all    
clear all
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

banda=8

    if(banda==1) %delta
        frec='delta';
        FRANGE=[1:0.2:3];
        colorBar=[1.1 1.35];    %norm1 
    elseif(banda==2) %theta
         frec='theta';
        FRANGE=[4:0.2:8];
        %colorBar=[1.07 1.25];       %norm1
        colorBar=[0.1 0.4];      %norm2
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
        %colorBar=[1.04 1.23];       %norm1
        colorBar=[0.1 0.35];        %norm2
    elseif(banda==4) %beta
        frec='beta';
        FRANGE=[12:1:35];
        %colorBar=[0.97 1.2];       %norm1
        colorBar=[0.08 0.33];       %norm2
    elseif(banda==5) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
        %colorBar=[0.98 1.2];       %norm1
        colorBar=[0.1 0.35];        %norm2
    elseif(banda==6) %beta2
         frec='beta2';
        FRANGE=[22:0.5:35];
        %colorBar=[0.98 1.12];       %norm1
        colorBar=[0.08 0.28];       %norm2
    elseif(banda==7) %total
         frec='total';
        FRANGE=[1:1:35];
        %colorBar=[0.96 1.237];       %norm1
        colorBar=[0.05 0.45];    %norm2
    elseif(banda==8) %totalCut
        frec='totalCut';
        FRANGE=[4:1:35];   %saco delta
        colorBar=[0.05 0.35];
    end  
%%

totalCond=[];

for j=1:4 %condiciones    
    totalSuj=[]; %la limpio para la proxima condicion
    for i=1:22
            load(['C:\EEG\priming\fft\cond_',num2str(j),'\',frec,'\t2Norm2\s',num2str(i),'.mat']); 
            pmedioRhoP2=mean(RhoP2,4);  %promedio de todas las epocas para cada sujeto;
            pmedioRhoP2=mean(pmedioRhoP2,1);  %promedio de todos los canales para cada sujeto;
            squeeze(pmedioRhoP2);
            totalSuj=[totalSuj; pmedioRhoP2]; %(:,1:largoMin,:);
    end
    pmedioSuj=mean(totalSuj,1); %promedio en sujetos
    totalCond=[totalCond; pmedioSuj];
end

pmedioCond=squeeze(mean(totalCond,1)); %promedio en condiciones
pmedioEjeX2=squeeze(mean(EjeX2,3)); %promedio en epocas
pmedioEjeF2=squeeze(mean(EjeF2,3)); %promedio en epocas
%% Grafico el promedio

imagesc(pmedioEjeX2/1000,pmedioEjeF2,pmedioCond',colorBar);
%ylim([5,30]);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');

[X,Y]   = meshgrid(1:size(pmedioCond,1), 1:length(FRANGE));

[X2,Y2] = meshgrid(1:0.05:size(pmedioCond,1), 1:0.1:length(FRANGE));

 sujFilt = interp2(X, Y, pmedioCond', X2, Y2, 'linear');
 
 figure();
 
 imagesc(pmedioEjeX2/1000,pmedioEjeF2,sujFilt,colorBar);
 
 %ylim([5,30]);
xlabel('tiempo (s)');
ylabel('frecuencia (Hz)');