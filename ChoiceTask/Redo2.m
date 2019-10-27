function [choiceSZ, choiceCondition, bonus]=Redo2(pms,data)

%% choose by amount:
% randomChoice=randsample(data.trialNumber(data.choiceAmount==pms.redoAmount),1);
% bonus=pms.redoAmount

%% choose by set size, even/odd choice between sz 3 or 4
        randomChoice=randsample(data.trialNumber(data.typeTask<5) ,1);

% bonus=data.choiceAmount(randomChoice);
choiceSZ=data.sz(randomChoice);

switch data.typeTask(randomChoice)
    case {1 2} %sz1 vs 3
        if data.choice(randomChoice==1)
            choiceSZ=1;
        elseif data.choice(randomChoice==2)
            choiceSZ=3;
        end
        
    case {3 4 5 6 7 8}
            choiceSZ=data.sz(randomChoice);
end

switch data.typeTask(randomChoice)

    case {3 4} %direct comparison
        if data.choice(randomChoice)==1
            choiceCondition=2;
        elseif data.choice(randomChoice)==2
            choiceCondition=0;
        end
        
    case { 1 2 5 6 7 8}
        choiceCondition=data.condition(randomChoice);

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
