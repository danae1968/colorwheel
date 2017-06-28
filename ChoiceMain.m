%%%%%%%Colorwheel behavioral study script%%%%%%%%%%
clear all
close all

subNo= input('Subject ID: ');
sessionNo=input('Session:  ');
checked=input(sprintf('participant number is %d and session %d',subNo,sessionNo));

% create directories.
rootdir         = pwd;
logdir          = fullfile(rootdir,'Log');
chdir           = fullfile(rootdir,'ChoiceTask');

if ~exist(logdir,'dir')
    mkdir(rootdir,'Log');
end

choiceDir = fullfile(logdir,'ChoiceTask');
if ~exist(choiceDir,'dir')
    mkdir(choiceDir);
end

subdirCh = fullfile(choiceDir,sprintf('Choices_sub_%d_session_%d',subNo,sessionNo));

if ~exist(subdirCh,'dir')
    mkdir(choiceDir,sprintf('Choices_sub_%d_session_%d',subNo,sessionNo));
else
    errordlg('Caution! Participant file name already exists!','Filename exists');
    return
end


%%% choice task

cd(chdir)
BeautifulChoices(subNo,1,subdirCh,sessionNo);
BeautifulChoices(subNo,0,subdirCh,sessionNo);
cd(rootdir)


