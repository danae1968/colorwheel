%%%%%%%Colorwheel behavioral study script%%%%%%%%%%
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

pms.runColorVision=0;
pms.runColorwheelPr=1;
pms.runColorwheel=1;
pms.runChoicePr=0;
pms.runChoice=0;
pms.runRedo=0;

rng('shuffle')
%% make folders for colorwheel
colordir=fullfile(logdir,'Colorwheel');

if ~exist(colordir,'dir')
    mkdir(logdir,'Colorwheel');
end


subdir = fullfile(colordir,sprintf('Colorwheel_sub_%d',subNo));

if ~exist(subdir,'dir')
    mkdir(colordir,sprintf('Colorwheel_sub_%d',subNo));
else
    warning('Caution! Participant file name already exists!');
    WaitSecs(2)
end

%% color vision test
    pms.background          = [128,128,128];
    pms.subNo = subNo;
    pms.colordir= subdir;
    pms.numWheelColors=512;
    pms.colorTrials=12; %trials for color naming task
cd(cwdir)

if pms.runColorVision
    disp('TASK 1: Colorwheel');          % display which task starts.
        WaitSecs(2)
    colorVisionDUTCH(pms)
end

%% colorwheel memory task
if pms.runColorwheelPr
cd(cwdir)
 BeautifulColorwheel(subNo,1,subdir,pms) %practice=1
end

if pms.runColorwheel
    cd(cwdir)
BeautifulColorwheel(subNo,0,subdir,pms) %practice=0

cd(rootdir)
end
%% choice task directories
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
    warning('Caution! Participant file name already exists!');
    WaitSecs(2)
end


%% choice task 

cd(chdir)
if pms.runChoicePr
% BeautifulChoices2(subNo,1,subdirCh,pms);%practice=1
BeautifulChoices(subNo,1,subdirCh,pms);%practice=1

end

if pms.runChoice

  [~,choiceSZ, choiceCondition, bonus]=BeautifulChoices2(subNo,0,subdirCh,pms);%actual choice task
end

%% redo of colorwheel task
if pms.runRedo
 cd(cwdir)
BeautifulColorwheel(subNo,2,subdir,choiceSZ,choiceCondition,bonus)
 end
