function [data]=defChoices(pms)
%This function defines the trial setup of the choice task

%% 1) Define trialstructure: 
if pms.practice == 1
    pms.nCalTrials = pms.nCalTrials_prac;
    pms.Choices = pms.Choices_prac;
end
%assign value to task condition (1:8, 1:i1-i3, 2: u1-u3, 3: i1-u1, 4: i3-u3, 5: i1-nr, 6: i3-nr, 6: u1-nr 8: u3-nr)
trl_struct = repmat((1:length(pms.typeTask)),pms.Choices/length(pms.typeTask),1); trl_struct=trl_struct(:); % array of task labels for calibration trials: 1:3 IGN; 4:6 UPD
trl_num=repmat(1:pms.nCalTrials,1,pms.Choices/pms.nCalTrials)';
adjAmt=repmat(pms.step,1,pms.Choices/pms.nCalTrials)';
% 

calTrlAmt = repmat(ones(length(pms.typeTask),1),pms.nCalTrials,1);

% indices for random order of trials
randIndCal = randperm(pms.Choices);

trlArray = [trl_struct(randIndCal), calTrlAmt(randIndCal), ones(length(randIndCal),1) trl_num(randIndCal) adjAmt(randIndCal) ];
% add counter of condition (maximum of 12)
ctr = zeros(pms.Choices*length(pms.amts),1);
for j = 1:size(trlArray,1)
    ctr(trlArray(j,1)+length(pms.typeTask)*(trlArray(j,2)-1),1) = ctr(trlArray(j,1)+length(pms.typeTask)*(trlArray(j,2)-1),1) + 1;
    trlArray(j,4) = ctr(trlArray(j,1)+length(pms.typeTask)*(trlArray(j,2)-1),1); % count trial numbers
end


for i=1:size(trlArray,1)
switch trlArray(i,4)
    case 1
        trlArray(i,5)=pms.step(1);
    case 2
        trlArray(i,5)=pms.step(2);
    case 3  
        trlArray(i,5)=pms.step(3);
    case 4
        trlArray(i,5)=pms.step(4);
    case 5
        trlArray(i,5)=pms.step(5);
end
end

   
%randomize left right presentation of easy option: divide by two because should be equal for IG and UP (apply same indices to both later on)
locationEasy = randi(2,1,pms.Choices); %1 means left and 2 means right presentation of easy option
trlArray(:,end+1)=locationEasy';

%% set up data
% prepare data structure
data.trialNumber = (1:pms.Choices)';
data.tskAmtTrlNm = trlArray(:,4); % trial number for each task-amount pair
data.choiceOnset = nan(pms.Choices,1); % onset timestamp
data.choiceRT = nan(pms.Choices,1); % choice response latency
data.choice = nan(pms.Choices,1); % participant's selection: 1 = easy, 2 = hard
data.typeTask = trlArray(:,1); % task being offered (versus the easy task)
data.adjEff = ones(pms.Choices,1); % task being discounted (set after first choice for each hardTask) 1 = easy 2 = hard
%data.prox = pms.prox(trlArray(:,3))'; % proximity to indifference point
%data.amt = pms.amts(trlArray(:,2)); % base (undiscounted) offer amount
% data.adjAmtAbs = trlArray(:,5); %absolute value of change as a consequence of decision on the trial
data.adjAmt = trlArray(:,5); % amount of offer adjustment pursuant to choice on current trial
data.sz = nan(pms.Choices,1);
data.condition = nan(pms.Choices,1);
data.hardOffer=repmat(pms.hardOffer,length(trlArray),1);
data.easyOffer=repmat(pms.hardOffer,length(trlArray),1);
data.locationEasy = trlArray(:,6);
% set anounts to base offer for hard tasks and half the base
% for easy tasks for first trial in each task-base offer pair

for i = 1:(pms.Choices)
    switch data.typeTask(i)
        case {3 5 7} %setsize 1 (versus No redo)
            data.sz(i) =1;
     
        case {4 6 8}  %setsize 3 (versus No redo)
            data.sz(i) =3;
     
    end
        switch data.typeTask(i)
            case {1 5 6} %all IGNORE
                data.condition(i) = 0;
            case {2 7 8} %all UPDATE
                data.condition(i) = 2;
        end
end





end %function

                

 