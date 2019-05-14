close all
clear all
%%

banda=5;
vent=3;
roi=1;

%saque delta

 if(banda==2) %theta
        frec='theta';
        FRANGE=[4:0.2:8];
        if vent==1
            ti=2;
            tf=6;
            colorBar=[0.15 0.34];
            if roi==1
                ROI=[28 2 17 10 20];  %frontal
            elseif roi==2
                ROI=[19 29 25 12];  %occipital
            end
        elseif vent==2
            ti=10;
            tf=13;
            colorBar=[0.05 0.34];
             if roi==1
                ROI=[28 2 17 10];  %frontal
             end
         elseif vent==3
            ti=15;
            tf=17;
            colorBar=[0.02 0.34];
             if roi==1
                ROI=[28 2 17 10];  %frontal
             end
        end
    elseif(banda==3) %alfa
        frec='alfa';
        FRANGE=[8:0.2:12];
        if vent==1
            ti=2;
            tf=6;
            colorBar=[0.15 0.32];
            if roi==1
                ROI=[28 2 17 10 20];  %frontal
            elseif roi==2
                ROI=[19 29 25 12];  %occipital
            end
        elseif vent==2
            ti=10;
            tf=13;
            colorBar=[0.04 0.35];
             if roi==1
                ROI=[28 2 17 10];  %frontal
             end
         elseif vent==3
            ti=15;
            tf=17;
            colorBar=[0.02 0.35];
             if roi==1
                ROI=[28 2 17 10];  %frontal
             end
        end
    elseif(banda==5) %beta1
         frec='beta1';
        FRANGE=[12:0.5:22];
        if vent==1
            ti=2;
            tf=6;
            colorBar=[0.14 0.29];
            if roi==1
                ROI=[28 2 17 20];  %frontal
            elseif roi==2
                ROI=[19 29 25 12];  %occipital
            end
        elseif vent==2
            ti=9;
            tf=11;
            colorBar=[0.05 0.23];
             if roi==1
                ROI=[28 2 17 10];  %frontal
             end
         elseif vent==3
            ti=14;
            tf=16;
            colorBar=[0.03 0.25];
             if roi==1
                ROI=[28 2 17 10];  %frontal
             end
        end
     end
    
   RhoP2suj=[];
  RhoP2cond=[]; 
%zeros(30,largoMin,length(FRANGE));


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

[p,tbl,stats] = anova1(matP');
p