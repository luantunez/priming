%voy a comentar todo lo que sea sacar Pvalue porque tengo un solo sujeto
%(que son todos ya promediados antes de la fft)
close all
clear all
clc
%% 

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='1';

ppal = 'direccion ppal';

filepathIN  = 'D:\EEG\priming48hs\datos\';
        
EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', [filepathIN,'cond_1',]);
EEG = eeg_checkset( EEG );  
localizacion=EEG.chanlocs;

figure();

%%

banda=5;
vent=2;
%roi=1;

%saque delta

ROI2=[28 2 17 10];	%frontal
pos2='ROI frontal';
ROI5=[20 21 18 24 25];	%central
pos5='ROI central';
ROI8=[4 19 29 12];	%occipital
pos8='ROI occipital';
ROI4=[22 3 26];	%izquierdo
pos4='ROI cental izquierdo';
ROI6=[23 11 27];	%derecho
pos6='ROI central derecho';

    if(banda==1) %delta
        frec='theta';
        FRANGE=[1:0.2:3];
        if vent==1
            ti=7;
            tf=12;
            colorBar=[-1 1.2];
        elseif vent==2
            ti=8;
            tf=12;
            colorBar=[-1 1.2];
        end
    elseif(banda==2) %theta
        frec='theta';
        FRANGE=[4:0.2:8];
        if vent==1
            ti=7;
            tf=12;
            colorBar=[-1 1.2];
        elseif vent==2
            ti=8;
            tf=12;
            colorBar=[-1 1.2];
        end
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
        if vent==1
            ti=7;
            tf=12;
            colorBar=[-1 1.2];
        elseif vent==2
            ti=8;
            tf=12;
            colorBar=[-1 1.2];
        end
    elseif(banda==5) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
        if vent==1
            ti=7;
            tf=12;
            colorBar=[-1 1.2];
        elseif vent==2
            ti=8;
            tf=12;
            colorBar=[-1 1.2];
        end
      end
    
  %RhoP2suj=[];
  RhoP2cond=[]; 
%zeros(30,largoMin,length(FRANGE));

       
%% sumo ROIs
 
clustPmedio=zeros(1,4);
clustErr=zeros(1,4);
%matP=zeros(4,20);
%totMatP=zeros(20,4,5);
%l=1;

for k=1:9
        if k==2 || k==4 || k==5 || k==6 || k==8  %numero de ROI
            for i=1:4 %condiciones
                suj=load(['D:\EEG\priming48hs\fft\ERPtotSujCond\cond_',num2str(i),'\',frec,'\t2Norm\sujPmedio.mat']); 

                %RhoP2ep=squeeze(mean(suj.RhoP2,4));  %promedio en epocas
                %->no hay epocas, se promediaron antes de hacer la fft
                RhoP2vent=suj.RhoP2(:,ti:tf,:);
                RhoP2pmedio=squeeze(mean(RhoP2vent,3));     %promedio en frecuencias
                RhoP2pmedio=squeeze(mean(RhoP2pmedio,2));   %promedio en tiempos

                ROI=eval(['ROI',num2str(k)]);

                 %matP(i,:)=squeeze(mean(RhoP2suj(ROI,:),1));     %asigno los valores para todos los sujetos para sacar el P value del ANOVA

                 RhoP2chanPmedio=squeeze(mean(RhoP2pmedio(ROI,:),1));  %promedio en los canales de la ROI para todos los sujetos
                 %errSujPmedio=std(RhoP2sujPmedio)/sqrt(length(RhoP2sujPmedio)); %saco error
                 clustPmedio(i)=mean(RhoP2chanPmedio); %lo guardo en un vector de promedios
                 %clustErr(i)=errSujPmedio; %lo guardo en un vector de errores               

            end
        
            subplot(3,3,k)
            bar([1,2,3,4], [clustPmedio(1),clustPmedio(2),clustPmedio(3),clustPmedio(4)]);
            %hold on
            %errorbar([1,2,3,4], [clustPmedio(1),clustPmedio(2),clustPmedio(3),clustPmedio(4)],[clustErr(1),clustErr(2),clustErr(3),clustErr(4)],'r.');
            %ylim([0,0.3]);
            hold on
            set(gca,'xticklabel',{'cond1', 'cond2','cond3', 'cond4'});
            pos=eval(['pos',num2str(k)]);
            title(pos);
            
            %totMatP(:,:,l)=matP'; %guardo la martiz para sacar el pvalue de los graficos de barras de los ROI -> orden: frontal, izquierdo, central, derecho, occipital
            %l=l+1;
            
        end

end

%% topoplot

RhoP2cond=[]; 

k=[1 3 7 9];

for i=1:4 %condiciones

        suj=load(['D:\EEG\priming48hs\fft\ERPtotSujCond\cond_',num2str(i),'\',frec,'\t2Norm\sujPmedio.mat']); 

        %RhoP2ep=squeeze(mean(suj.RhoP2,4));  %promedio en epocas
        %->no hay epocas, se promediaron antes de hacer la fft
        RhoP2vent=suj.RhoP2(:,ti:tf,:);
        RhoP2pmedio=squeeze(mean(RhoP2vent,3));     %promedio en frecuencias
        RhoP2pmedio=squeeze(mean(RhoP2pmedio,2));   %promedio en tiempos
                
         subplot(3,3,k(i));
         topoplot(RhoP2pmedio',localizacion,'maplimits',colorBar);
         title(['condicion ',num2str(i)]);

         RhoP2cond=[RhoP2cond RhoP2pmedio];  %sumo todas las condiciones
end


RhoP2pmedioTot=squeeze(mean(RhoP2cond,2));  %promedio en condiciones

figure();
topoplot(RhoP2pmedioTot',localizacion,'maplimits',colorBar);
title('promedio condiciones');

clustPmedio

% for m=1:5
% 
% [p(m),tbl,stats] = anova1(totMatP(:,:,m));
% 
% end



