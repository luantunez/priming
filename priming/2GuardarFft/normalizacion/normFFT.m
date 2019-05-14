%canales, tiempos, frecuencias, epocas

close all
clear all
    
addpath('C:\Users\lucía\Documents\MATLAB\EEG\EEG2\fft');

%for banda=1:7
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
    
    clear RhoP2;

    for i=1:4 %condiciones

        for j=1:22 %sujetos
            suj1=load(['D:\EEG\priming\fft\cond_',num2str(i),'\',frec,'\t1\s',num2str(j),'.mat']); %baseline
            %amplitud, no normalizo la fase
            Rho1=suj1.Rho1;
            Rho1=mean(Rho1,2); %colapso tiempos
            %Rho1=mean(Rho1,3); %colapso frecuencias
            RhoP1=squeeze(Rho1);     

            suj2=load(['D:\EEG\priming\fft\cond_',num2str(i),'\',frec,'\t2\s',num2str(j),'.mat']); %priming
            Rho2=suj2.Rho2;
                    %Para volver a guardarlos
            Phi2=suj2.Phi2;
            EjeX2=suj2.EjeX2;
            EjeF2=suj2.EjeF2;

            for k=1:30 %canales
                for l=1:size(RhoP1,3) %epocas
                    for m=1:size(RhoP1,2) %frecuencias
                    div=RhoP1(k,m,l);
                    RhoP2(k,:,m,l)=Rho2(k,:,m,l)/div;  %normalizado
                    end
                end
            end
            save(['D:\EEG\priming\fft\cond_',num2str(i),'\',frec,'\t2Norm\s',num2str(j),'.mat'],'RhoP2','Phi2','EjeX2','EjeF2');
        end
    end
    
%end