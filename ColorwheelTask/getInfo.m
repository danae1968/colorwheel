function [subNo,dataFilename,dataFilenamePrelim,practice,manipulation]=getInfo(varargin)
%asks for subject number and practice(0 for no practice, 1 for practice)
%via keyboard and provides subNo, practice status and file names for data.

switch nargin
    case 0
prompt1='subject number:';
subNo=input(prompt1);

prompt2='practice? Press 1 for practice and 0 for real task.';
practice=input(prompt2);

switch practice
    case 1
        prompt3=sprintf('participant %d will start practice now',subNo);
    case 0
        prompt3=sprintf('participant %d will start the colorwheel task now',subNo);
end
checked=input(prompt3);

    case 2
        subNo=varargin{1};
        practice=varargin{2};
end
% prompt3='manipulation:';
% manipulation=input(prompt3);
%task 1:manipulate delay 2:manipulate interference time
manipulation = 1;

if practice==0
    dataFilename = sprintf('ColorFun_s%d.mat',subNo);
    dataFilenamePrelim=sprintf('CF_s%d_pre.mat',subNo);
elseif practice==1
    dataFilename = sprintf('ColorFun_s%d_practice.mat',subNo);
    dataFilenamePrelim=sprintf('CF_s%d_pre_practice.mat',subNo);
end

if exist (dataFilename,'file')
    randAttach = round(rand*10000);
    dataFilename = strcat(dataFilename, sprintf('_%d.mat',randAttach));  
end

