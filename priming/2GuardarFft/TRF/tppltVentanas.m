close all
clear all

%%

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\EEG\datos';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;

figure();

%%

banda=6;
vent=4;

%saque delta

    if(banda==2) %theta
        frec='theta';
        FRANGE=[4:0.2:8];
        if vent==1
            ti=2;
            tf=6;
            colorBar=[0.07 0.37];
        elseif vent==2
            ti=10;
            tf=13;
            colorBar=[0.05 0.37];
         elseif vent==3
            ti=15;
            tf=17;
            colorBar=[0.02 0.37];
         elseif vent==4
            ti=21;
            tf=24;
            colorBar=[0.019 0.25];
        end
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
        if vent==1
            ti=2;
            tf=6;
            colorBar=[0.1 0.35];
        elseif vent==2
            ti=10;
            tf=13;
            colorBar=[0.04 0.35];
         elseif vent==3
            ti=15;
            tf=17;
            colorBar=[0.02 0.35];
         elseif vent==4
            ti=21;
            tf=24;
            colorBar=[0.02 0.26];
        end
    elseif(banda==5) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
        if vent==1
            ti=2;
            tf=6;
            colorBar=[0.09 0.32];
        elseif vent==2
            ti=9;
            tf=11;
            colorBar=[0.05 0.23];
         elseif vent==3
            ti=14;
            tf=16;
            colorBar=[0.03 0.25];
         elseif vent==4
            ti=21;
            tf=24;
            colorBar=[0.05 0.22];
        end
    elseif(banda==6) %beta2
         frec='beta2';
        FRANGE=[22:0.5:35];
        if vent==1
            ti=1;
            tf=3;
            colorBar=[0.12 0.30];
        elseif vent==2
            ti=9;
            tf=11;
            colorBar=[0.07 0.17];
         elseif vent==3
            ti=14;
            tf=16;
            colorBar=[0.09 0.19];
         elseif vent==4
            ti=21;
            tf=24;
            colorBar=[0.11 0.25];
        end
     end
    
   RhoP2suj=[];
  RhoP2cond=[]; 
%zeros(30,largoMin,length(FRANGE));

for i=1:4 %condiciones
    
    for j=1:22 %sujetos
            suj=load(['D:\EEG\priming\fft\cond_',num2str(i),'\',frec,'\t2Norm2\s',num2str(j),'.mat']); 
            
            RhoP2ep=squeeze(mean(suj.RhoP2,4));  %promedio en epocas
            RhoP2vent=RhoP2ep(:,ti:tf,:);
            RhoP2pmedio=squeeze(mean(RhoP2vent,3));     %promedio en frecuencias
            RhoP2pmedio=squeeze(mean(RhoP2pmedio,2));   %promedio en tiempos

            RhoP2suj=[RhoP2suj RhoP2pmedio] ; %sumo todos los sujetos
    end
     RhoP2sujPmedio=squeeze(mean(RhoP2suj,2));  %promedio en sujetos
     
     subplot(2,2,i);
     topoplot(RhoP2sujPmedio',localizacion,'maplimits',colorBar);
     title(['condicion ',num2str(i)]);
     
     RhoP2cond=[RhoP2cond RhoP2sujPmedio];  %sumo todas las condiciones
end

RhoP2pmedioTot=squeeze(mean(RhoP2cond,2));  %promedio en condiciones

figure();
topoplot(RhoP2sujPmedio',localizacion,'maplimits',colorBar);
title('promedio condiciones');

