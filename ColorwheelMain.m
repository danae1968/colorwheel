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

runVersion2=0;
runColorVision=0;
runColorwheelPr=0;
runColorwheel=0;
runChoicePr=0;
runChoice=0;
runRedo=0;

rng('shuffle')
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

%% color vision test
    pms.background          = [128,128,128];
    pms.subNo = subNo;
    pms.colorDir= subDir;
    pms.numWheelColors=512;
    pms.colorTrials=12; %trials for color naming task
cd(cwdir)

if runColorVision
    disp('TASK 1: Colorwheel');          % display which task starts.
        WaitSecs(2)
    colorVisionDUTCH(pms,wPtr,rect)
end

if runColorwheelPr
cd(cwdir)
 BeautifulColorwheel(subNo,1,subdir) %practice=1
end

if runColorwheel
    cd(cwdir)
BeautifulColorwheel(subNo,0,subdir) %practice=0

cd(rootdir)
end
%% choice task
if runChoicePr
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
BeautifulChoices(subNo,1,subdirCh);%practice=1
end

if runChoice
if runVersion2==0
[~,choiceSZ, choiceCondition, bonus]=BeautifulChoices(subNo,0,subdirCh);%actual choice task
elseif runVersion2==1
  [~,choiceSZ, choiceCondition, bonus]=BeautifulChoices2(subNo,0,subdirCh);%actual choice task
end  
end

%% redo of colorwheel task
if runRedo
 
 end
