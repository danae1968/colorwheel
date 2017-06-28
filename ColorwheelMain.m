%%%%%%%Colorwheel behavioral study script%%%%%%%%%%
clear all
close all

subNo= input('Subject ID: ');
sessionNo=input('Session:  ');
checked=input(sprintf('participant number is %d and session %d',subNo,sessionNo));

% create directories.
rootdir         = pwd;
logdir          = fullfile(rootdir,'Log');
cwdir           = fullfile(rootdir,'ColorwheelTask');

if ~exist(logdir,'dir')
    mkdir(rootdir,'Log');
end
colordir=fullfile(logdir,'Colorwheel');

if ~exist(colordir,'dir')
    mkdir(logdir,'Colorwheel');
end


subdir = fullfile(colordir,sprintf('Colorwheel_sub_%d_session_%d',subNo,sessionNo));

if ~exist(subdir,'dir')
    mkdir(colordir,sprintf('Colorwheel_sub_%d_session_%d',subNo,sessionNo));
else
    errordlg('Caution! Participant file name already exists!','Filename exists');
    return
end

cd(cwdir)

disp('TASK 1: Colorwheel');          % display which task starts.
WaitSecs(2)

BeautifulColorwheel(subNo,1,subdir,sessionNo) %practice=1
BeautifulColorwheel(subNo,0,subdir,sessionNo) %practice=0

cd(rootdir)


