%%%%%%%Colorwheel behavioral study script%%%%%%%%%%
clear all
close all

subNo= input('Subject ID: ');
checked=input(sprintf('participant number is %d',subNo));

% create directories.
rootdir         = pwd;
logdir          = fullfile(rootdir,'Log');
cwdir           = fullfile(rootdir,'ColorwheelTask');

if ~exist(logdir,'dir')
    mkdir(rootdir,'Log');
end

%% colorwheel memory task

colordir=fullfile(logdir,'Colorwheel');

if ~exist(colordir,'dir')
    mkdir(logdir,'Colorwheel');
end


subdir = fullfile(colordir,sprintf('Colorwheel_sub_%d',subNo));

if ~exist(subdir,'dir')
    mkdir(colordir,sprintf('Colorwheel_sub_%d',subNo));
else
    errordlg('Caution! Participant file name already exists!','Filename exists');
    return
end

cd(cwdir)
disp('TASK 1: Colorwheel');          % display which task starts.
WaitSecs(2)

BeautifulColorwheel(subNo,1,subdir) %practice=1
BeautifulColorwheel(subNo,0,subdir) %practice=0

cd(rootdir)

%% choice task
chdir           = fullfile(rootdir,'ChoiceTask');

if ~exist(logdir,'dir')
    mkdir(rootdir,'Log');
end

choiceDir = fullfile(logdir,'ChoiceTask');
if ~exist(choiceDir,'dir')
    mkdir(choiceDir);
end

subdirCh = fullfile(choiceDir,sprintf('Choices_sub_%d',subNo));

if ~exist(subdirCh,'dir')
    mkdir(choiceDir,sprintf('Choices_sub_%d',subNo));
else
    errordlg('Caution! Participant file name already exists!','Filename exists');
    return
end


%%% choice task main script

cd(chdir)
BeautifulChoices(subNo,1,subdirCh);
[~,choiceSZ, choiceCondition, bonus]=BeautifulChoices(subNo,0,subdirCh);

%% redo of colorwheel task
cd(cwdir)
BeautifulColorwheel(subNo,2,subdir,choiceSZ,choiceCondition,bonus)