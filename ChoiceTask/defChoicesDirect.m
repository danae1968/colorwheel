function [data]=defChoicesDirect(pms)
%This function defines the trial setup of the choice task

%% 1) Define trialstructure: 
% if pms.practice == 1
%     pms.nCalTrials = pms.nCalTrials_prac;
%     pms.Choices = pms.Choices_prac;
%     pms.nBlocks = pms.nBlocks_prac;
% else

pms.Choices=length(pms.setSize)*pms.nCalTrials;
pms.nBlocks=pms.Choices/(2*length(pms.setSize));
block1 = (1:pms.Choices)';

block2=repmat(pms.setSize, 1,pms.Choices/length(pms.setSize));
%use this version if we want to block presentation of easy offer instead of
%randomizing
% if rand<0.5
%     locations=[1 2];
% else
%     locations=[2 1];
% end
% locationEasy=repmat(locations,pms.Choices/pms.nBlocks,pms.nBlocks/length(locations));
% locationEasy=locationEasy(:);


locationEasy=repmat([1,2],pms.setSize,pms.Choices/length([1,2]));locationEasy=locationEasy(:);

index=Shuffle(1:pms.Choices)';
block=[block1 block2(index)'];
%trl_struct = repmat((1:length(pms.hardTask)*length(pms.Conditions))',pms.nCalTrials*length(pms.amts),1); % array of task labels for calibration trials: 1:3 IGN; 4:6 UPD

% only use 1 here
calTrlAmt = []; % unpermutted array of calibration trial amounts and absolute value of amount adjustments
for j = 1:length(pms.amts)
    tmp = repmat(j,length(pms.setSize),1);
    calTrlAmt = [calTrlAmt; tmp];
end
calTrlAmt = repmat(calTrlAmt,pms.nCalTrials,1);

% indices for random order of trials
%randIndCal = randperm(pms.Choices);
trlArray = [block(:,2), calTrlAmt, ones(pms.Choices,1)];

% add counter of condition (maximum of 12)
ctr = zeros(pms.Choices*length(pms.amts),1);
for j = 1:size(trlArray,1)
    ctr(trlArray(j,1)+length(pms.setSize)*(trlArray(j,2)-1),1) = ctr(trlArray(j,1)+length(pms.setSize)*(trlArray(j,2)-1),1) + 1;
    trlArray(j,4) = ctr(trlArray(j,1)+length(pms.setSize)*(trlArray(j,2)-1),1); % count trial numbers
end

adjAmt = nan(pms.Choices,1);
adjAmt(:) = pms.amts.step;
% trlArray = [trlArray calAdjustment];

% trlArray(:,5)=locationEasy;
trlArray(:,5)=locationEasy(index);

%% set up data
% prepare data structure
data.trialNumber = (1:pms.Choices)';
data.block = block(:,1);
data.tskAmtTrlNm = trlArray(:,4); % trial number for each task-amount pair
data.choiceOnset = nan(pms.Choices,1); % onset timestamp
data.choiceRT = nan(pms.Choices,1); % choice response latency
data.choice = nan(pms.Choices,1); % participant's selection: 1 = easy, 2 = hard
data.hardTask = trlArray(:,1); % task being offered (versus the easy task)
data.adjEff = ones(pms.Choices,1); % task being discounted (set after first choice for each hardTask) 1 = easy 2 = hard
data.prox = pms.prox(trlArray(:,3))'; % proximity to indifference point
%data.amt = pms.amts(trlArray(:,2)); % base (undiscounted) offer amount
% data.adjAmtAbs = trlArray(:,5); %absolute value of change as a consequence of decision on the trial
data.adjAmt = adjAmt; % amount of offer adjustment pursuant to choice on current trial
data.sz = nan(pms.Choices,1);
data.condition = nan(pms.Choices,1);
data.locationEasy = trlArray(:,5);
% set anounts to base offer for hard tasks and half the base
% for easy tasks for first trial in each task-base offer pair

data.easyOffer = pms.amts.start.*(trlArray(:,4)==1); % offer amount for easy task first time
data.hardOffer = pms.amts.max.*(trlArray(:,4)==1); % offer amount for hard task

for i = 1:pms.Choices
    data.sz(i)=data.hardTask(i);
end
      

end %function

                

 