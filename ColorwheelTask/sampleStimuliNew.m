function [trial]=sampleStimuliNew
% function that samples and shuffles the defined stimuli for the colorwheel task.
%more information about the defined stimuli in readinStimuli.m.

numTrials=64;
numBlocks=2;
%stimuli are counterbalanced by sets of 8
counterN=4;
setSize=1:4;
%how many trials we need per set size
numPerSZ=(numTrials*numBlocks)/length(setSize);
%matrix created in readingStimuli.m
load stimuli.mat

%to sample for different amounts of trials/blocks and not lose
%the counterbalancing,the stimuli are split in counterbalanced columns of
%counterN
sz1=reshape(sz1,counterN,length(sz1)/counterN);
sz2=reshape(sz2,counterN,length(sz2)/counterN);
sz3=reshape(sz3,counterN,length(sz3)/counterN);
sz4=reshape(sz4,counterN,length(sz4)/counterN);

block1=[sz1(2:3,:);sz2(2:3,:);sz3(2:3,:);sz4(2:3,:)];block1=block1(:);
index1=randperm(length(block1));
block1=block1(index1);

block2=[sz1([1,4],:);sz2([1,4],:);sz3([1,4],:);sz4([1,4],:)];block2=block2(:);
index2=randperm(length(block2));
block2=block2(index2);

trial=[block1,block2];

save('trial','trial')
end