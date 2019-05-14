addpath('C:\Users\lucía\Documents\eeglab14_1_1b')
eeglab;

%ppal = 'direccion ppal';
filepathIN  = 'D:\EEG\priming48hs\datos\';
        
for j=1:4
    for i=1:1:20

        EEG = pop_loadset('filename',[num2str(i),'.set'], 'filepath', [filepathIN,'cond_',num2str(j)]);
        EEG = eeg_checkset( EEG );

        datos=EEG.data;
        times =EEG.times;
        save(['D:\EEG\priming48hs\estructuras\cond_',num2str(j),'\s',num2str(i)],'datos','times')

    end
end