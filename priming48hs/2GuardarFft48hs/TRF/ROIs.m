close all
clear all
clc
%%

addpath('C:\Users\lucía\Documents\eeglab14_1_1b');
eeglab;

NOMBRE='s1';

ppal = 'direccion ppal';

filepathIN  = 'C:\EEG\datos';

EEG = pop_loadset('filename',[NOMBRE,'.set'], 'filepath', filepathIN);
EEG = eeg_checkset( EEG );
localizacion=EEG.chanlocs;

%%

banda=3;
vent=3;
roi=1;

%saque delta

    if(banda==2) %theta
        frec='theta';
        
        if vent==1
            ti=2;
            tf=6;
            if roi==1
                ROI=[19 29 25 12];     %abajo
            elseif roi==2
                ROI=[1 30 9 28];     %arriba
            end
         
        elseif vent==2
            ti=10;
            tf=13;
            if roi==1
                ROI=[19 29 25 12]      %arriba
            end
            
         elseif vent==3
            ti=15;
            tf=17;
            if roi==1
                ROI=[19 29 25 12]      %arriba
            end
              
         elseif vent==4
            ti=21;
            tf=24;
            if roi==1
                ROI=[19 29 25 12]      %arriba
            elseif roi==2           
                ROI=[13 12 27 16];     %occipital derecha
            end
        end
   
    elseif(banda==3) %alfa
        frec='alfa';
        
        if vent==1
            ti=2;
            tf=6;
            if roi==1
                ROI=[19 29 25 12];     %abajo
            elseif roi==2
                ROI=[1 30 9 28];     %arriba
            end
            
        elseif vent==2
            ti=10;
            tf=13;
            if roi==1
                ROI=[1 30 9 28];     %arriba
            end  
            
         elseif vent==3
            ti=15;
            tf=17;
            if roi==1
                ROI=[1 30 9 28];     %arriba
            end
            
         elseif vent==4
            ti=21;
            tf=24;
            if roi==1
                ROI=[1 30 9 28];     %arriba
            elseif roi==2
                ROI=[19 29 25 12];     %occipital derecha
                end
        end
        
    elseif(banda==5) %beta1
         frec='beta1';
        
        if vent==1
            ti=2;
            tf=6;
            if roi==1
                ROI=[19 29 25 12];     %abajo
            elseif roi==2
                ROI=[30 9 28];     %arriba
            end
            
        elseif vent==2
            ti=9;
            tf=11;
            if roi==1
                ROI=[1 30 9 28];     %arriba
            end
            
         elseif vent==3
            ti=14;
            tf=16;
            if roi==1
                ROI=[11 30 9 28 2 17 10];     %arriba
            end
            
         elseif vent==4
            ti=21;
            tf=24;
            if roi==1
                ROI=[8 5 29];     %abajo izquierda
            elseif roi==2
                ROI=[1 30 9 28];     %arriba
            elseif roi==3 
                ROI=[13 12 27 16];      %abajo derecha
            end
        end
        
    elseif(banda==6) %beta2
         frec='beta2';
        
        if vent==1
            ti=1;
            tf=3;
            if roi==1
                ROI=[13 12 16];     %abajo derecha
            elseif roi==2
                ROI=[8 4 5 29];     %abajo izquierda
            end
            
        elseif vent==2
            ti=9;
            tf=11;
            if roi==1
                ROI=[5 29 12 13];     %abajo izquierda
            elseif roi==2
                ROI=[1 30 9 28];     %arriba
            end
            
         elseif vent==3
            ti=14;
            tf=16;
            if roi==1
                ROI=[13 12 27 16];     %abajo derecha
            elseif roi==2
                ROI=[8 5 13 29];     %abajo izquierda
            elseif roi==3
                ROI=[1 30 9 28];      %arriba centro
            elseif roi==4
                ROI=[6 1 2];     %arriba izquierda
            end
            
         elseif vent==4
            ti=21;
            tf=24;
            if roi==1
                ROI=[13 12 27 16];     %abajo derecha
            elseif roi==2
                ROI=[18 24 25 20 21];     %centro
            end
        end
 end
       
%% sumo ROIs
 
clustPmedio=zeros(1,4);
clustErr=zeros(1,4);
matP=zeros(4,22);

for i=1:4 %condiciones
    RhoP2suj=[];
    for j=1:22 %sujetos
            suj=load(['D:\EEG\priming\fft\cond_',num2str(i),'\',frec,'\t2Norm2\s',num2str(j),'.mat']); 
            
            RhoP2ep=squeeze(mean(suj.RhoP2,4));  %promedio en epocas
            RhoP2vent=RhoP2ep(:,ti:tf,:);
            RhoP2pmedio=squeeze(mean(RhoP2vent,3));     %promedio en frecuencias
            RhoP2pmedio=squeeze(mean(RhoP2pmedio,2));   %promedio en tiempos

            RhoP2suj=[RhoP2suj RhoP2pmedio] ; %sumo todos los sujetos
    end

     matP(i,:)=squeeze(mean(RhoP2suj(ROI,:),1))';     %asigno los valores para todos los sujetos para sacar el P value del ANOVA
     
     RhoP2sujPmedio=squeeze(mean(RhoP2suj(ROI,:),1));  %promedio en los canales de la ROI para todos los sujetos
     errSujPmedio=std(RhoP2sujPmedio)/sqrt(length(RhoP2sujPmedio)); %saco error
     clustPmedio(i)=mean(RhoP2sujPmedio); %lo guardo en un vector de promedios
     clustErr(i)=errSujPmedio; %lo guardo en un vector de errores
  
end

clustPmedio

bar([1,2,3,4], [clustPmedio(1),clustPmedio(2),clustPmedio(3),clustPmedio(4)]);
hold on
errorbar([1,2,3,4], [clustPmedio(1),clustPmedio(2),clustPmedio(3),clustPmedio(4)],[clustErr(1),clustErr(2),clustErr(3),clustErr(4)],'r.');
%ylim([0,0.3]);
hold on
set(gca,'xticklabel',{'condicion 1', 'condicion 2','condicion 3', 'condicion 4'});
%title('');

%[p,tbl,stats] = anova1(matP);
%p





