function [choiceSZ, choiceCondition, bonus]=Redo(pms,data)

%% choose by amount:
% randomChoice=randsample(data.trialNumber(data.choiceAmount==pms.redoAmount),1);
% bonus=pms.redoAmount

%% choose by set size, even/odd choice between sz 3 or 4
        randomChoice=randsample(data.trialNumber(data.version==2 & data.choice~=9) ,1);

% bonus=data.choiceAmount(randomChoice);
choiceSZ=data.sz(randomChoice);

switch data.version(randomChoice)
    case 1 %no redo
        switch data.typeTask(randomChoice)
            case {1 2 3 4} %all IGNORE
                choiceCondition = 0;
            case {5 6 7 8} %all UPDATE
                choiceCondition = 2;
        end
    case 2
        if data.choice(randomChoice)==1
            choiceCondition=2;
        elseif data.choice(randomChoice)==2
            choiceCondition=0;
        end
end


if data.choice(randomChoice)==1
    bonus=data.easyOffer(randomChoice);
elseif data.choice(randomChoice)==2
    bonus=data.hardOffer(randomChoice);
end
save(fullfile(pms.choicedir,sprintf('sub%d bonus',pms.subNo)),'bonus')

% trialvector=[zeros(1,pms.redoTrials/(2*pms.redoCondi)), 2*ones(1,(pms.redoTrials/(2*pms.redoCondi)))];
% typechoice=repmat(choiceCondition,pms.redoTrials/2,1);
% trialvector=[trialvector typechoice'];
% 
% setsize = [1,2,3,4]';
% setsizevector = repmat(setsize,pms.redoTrials/(2*length(setsize)),1);
% setsizechoice=repmat(choiceSZ,pms.redoTrials/2,1);
% setsizevector=[setsizevector ;setsizechoice];
