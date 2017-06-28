function [data]=defChoicesSZ(pms,blockType)
%This function defines the trial setup of the choice task

%% 1) Define trialstructure: 
if blockType==1
    pms.Choices=pms.ChoicesNoRedo;
    pms.nBlocks=pms.nBlocksNoRedo;
end

if pms.practice == 1
    pms.nCalTrials = pms.nCalTrials_prac;
    pms.Choices = pms.Choices_prac;
    pms.nBlocks = pms.nBlocks_prac;
end

%blocking choice task per set size
sz1=repmat([7,8]',pms.nCalTrials,1); %inde for sz 1
sz2 = repmat([1,4]',pms.nCalTrials,1); %index for sz 2
sz3 = repmat([2,5]',pms.nCalTrials,1); %index for sz 3
sz4 = repmat([3,6]',pms.nCalTrials,1); %index for sz 4

idx_sz1=Shuffle(sz1);
idx_sz2 = Shuffle(sz2); 
idx_sz3 = Shuffle(sz3);
idx_sz4=Shuffle(sz4);

% set size 2:4 are shuffled so that blocks are different for every participant in a
%random order. They are modded so that they won't cause problems when later
%substituted with 1:6

if blockType==1
    sz=pms.setSize;
elseif blockType==2
    sz=pms.hardTask;
end


% sz=pms.hardTask;
ind_sz=Shuffle(repmat(-sz,1,pms.nBlocks/length(sz)))'; %2:4 for all possible pairs


block = (repmat(1:pms.nBlocks,pms.Choices/pms.nBlocks,1)); block = block(:);
block2=repmat(ind_sz,1,pms.Choices/pms.nBlocks)';block2=block2(:);

if blockType==1
    block2(block2==-1) = idx_sz1;
end
block2(block2==-2) = idx_sz2;
block2(block2==-3) = idx_sz3;
block2(block2==-4) = idx_sz4;

block=[block block2];

    
%trl_struct = repmat((1:length(pms.hardTask)*length(pms.Conditions))',pms.nCalTrials*length(pms.amts),1); % array of task labels for calibration trials: 1:3 IGN; 4:6 UPD

% only use 1 here
calTrlAmt = []; % unpermutted array of calibration trial amounts and absolute value of amount adjustments
for j = 1:length(pms.amts)
    tmp = repmat(j,length(sz)*length(pms.Conditions),1);
    calTrlAmt = [calTrlAmt; tmp];
end
calTrlAmt = repmat(calTrlAmt,pms.nCalTrials,1);

% indices for random order of trials
%randIndCal = randperm(pms.Choices);
trlArray = [block(:,2), calTrlAmt, ones(pms.Choices,1)];

% add counter of condition (maximum of 12)
ctr = zeros(pms.Choices*length(pms.amts),1);
for j = 1:size(trlArray,1)
    ctr(trlArray(j,1)+length(sz)*(trlArray(j,2)-1),1) = ctr(trlArray(j,1)+length(sz)*(trlArray(j,2)-1),1) + 1;
    trlArray(j,4) = ctr(trlArray(j,1)+length(sz)*(trlArray(j,2)-1),1); % count trial numbers
end

adjAmt = nan(pms.Choices,1);
adjAmt(:) = pms.amts.step;
% trlArray = [trlArray calAdjustment];

%use this version if we want to block presentation of easy offer, instead
%of randomizing it
% locationEasy = randi(2,1,pms.Choices/2); %1 means left and 2 means right presentation of easy option
% if rand<0.5
%     locations=[1 2];
% else
%     locations=[2 1];
% end
% locationEasy=repmat(locations,pms.Choices/pms.nBlocks,pms.nBlocks/length(locations));
% locationEasy=locationEasy(:);
% trlArray(:,5)=locationEasy;

%randomize left right presentation of easy option: divide by two because should be equal for IG and UP (apply same indices to both later on)
locationEasy = randi(2,1,pms.Choices/2); %1 means left and 2 means right presentation of easy option
trlArray(trlArray(:,1)<4 |trlArray(:,1)==7,5) = locationEasy; %apply index to IGNORE trials (<4)
trlArray(trlArray(:,1)>3 &trlArray(:,1)~=7, 5) = fliplr(locationEasy); %apply (reversed) indices to UPDATE trials (>3)
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
data.blockType=blockType;
% set anounts to base offer for hard tasks and half the base
% for easy tasks for first trial in each task-base offer pair

data.easyOffer = pms.amts.start.*(trlArray(:,4)==1); % offer amount for easy task first time
data.hardOffer = pms.amts.max.*(trlArray(:,4)==1); % offer amount for hard task

for i = 1:pms.Choices
    switch data.hardTask(i)
        case {1 4} %setsize 2 (versus 1)
            data.sz(i) =2;
        case {2 5} %setsize 3 (versus 1)
            data.sz(i) =3;
        case {3 6}  %setsize 4 (versus 1)
            data.sz(i) =4;
        case {7 8}
            data.sz(i)=1;
    end
        switch data.hardTask(i)
            case {1 2 3 7} %all IGNORE
                data.condition(i) = 0;
            case {4 5 6 8} %all UPDATE
                data.condition(i) = 22;
        end
end
end %function

                

 
