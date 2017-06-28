function [data] = showChoiceTrial(pms, data, wPtr,rect, dataHeader)

%%%% setup at the beginning of a trial

%% What we need
% 1) general locations on screen
xlength = rect(3); %screen length x
ylength = rect(4); %screen height y
%define left centre (LC) and right centre (RC)
LC = [xlength/4, ylength/2];
RC = [xlength*(3/4), ylength/2];

% 2) size of squares
rectsize = [0 0 100 100];
rectsizeFB = [0 0 450 450];
FB_left = CenterRectOnPoint(rectsizeFB,LC(1),LC(2));
FB_right = CenterRectOnPoint(rectsizeFB,RC(1),RC(2));

% 3) locations of squares
% give and fine tune offset of centre
offset = 100; %offset (symmetrical)
locations_left = [LC + [-offset -offset]; LC + [offset -offset]; LC + [offset offset]; LC + [-offset offset]];
locations_right = [RC + [-offset -offset]; RC + [offset -offset]; RC + [offset offset]; RC + [-offset offset]];

% 4) text on screen while choice
msgUPD = 'U';
msgIGN = 'N';

%5) randomizations of locations

%randomize presentation of sz 1 (which of 4 positions)
idxLocation_sz1_randi = randi(size(locations_left,1),1,length(data.trialNumber)/2); %counterbalance between U and I (that's why the length is divided by 2)
idxLocation_sz1 = nan(length(data.trialNumber),1); %create NAN vector for the location indices (1-4)
idxLocation_sz1(data.condition==0) = idxLocation_sz1_randi; %fill condition 0 (IGNORE)
idxLocation_sz1(data.condition==22) = fliplr(idxLocation_sz1_randi); %fill condition 22 (UPD) with the reverse

%randomize presentation of sz 2,3,4 depending on setsize
for i = 1:(length(data.trialNumber)/2)
    idxLocation_sz2_randi(i,:) = randsample(1:size(locations_left,1),2,false);
    idxLocation_sz3_randi(i,:) = randsample(1:size(locations_left,1),3,false);
    idxLocation_sz4_randi(i,:) = randsample(1:size(locations_left,1),4,false);
end

idxLocation_sz2(data.condition==0,:) = idxLocation_sz2_randi; %fill condition 0 (IGNORE)
idxLocation_sz2(data.condition==22,:) = fliplr(idxLocation_sz2_randi); %fill condition 22 (UPD) with the reverse
idxLocation_sz3(data.condition==0,:) = idxLocation_sz3_randi; %fill condition 0 (IGNORE)
idxLocation_sz3(data.condition==22,:) = fliplr(idxLocation_sz3_randi); %fill condition 22 (UPD) with the reverse
idxLocation_sz4(data.condition==0,:) = idxLocation_sz4_randi; %fill condition 0 (IGNORE)
idxLocation_sz4(data.condition==22,:) = fliplr(idxLocation_sz4_randi); %fill condition 22 (UPD) with the reverse

%% Stimulus presentation starts here
for trial = 1:length(data.trialNumber)

    if trial == 1 || data.block(trial) - data.block(trial-1) == 1 %if the block of confition is about to change
        switch data.condition(trial)
            case {0}
                msgBlock = 'Next block.\n\n The following choices are all about NEGLECT ("N")';
            case {22}
                msgBlock = 'Next block.\n\n The following choices are all about UPDATE ("U")';
        end %switch
        
        DrawFormattedText(wPtr,msgBlock,'center',ylength*(1/2));
        Screen('Flip',wPtr);
        WaitSecs(6);
        
        save(dataHeader.dataFilenamePrelim)

    
    end %if
    
    msgHard = sprintf('for €%.2f',data.hardOffer(trial));
    msgEasy = sprintf('for €%.2f',data.easyOffer(trial));
    msgRespond = 'Go';
    
    switch data.locationEasy(trial)
        case 1 %means easy option left, hard right
            
            rect_sz1 = CenterRectOnPoint(rectsize,locations_left(idxLocation_sz1(trial),1),locations_left(idxLocation_sz1(trial),2)); %xy coordinates from current trial
            
            switch data.sz(trial)
                case 2                 % setsize 2
                    rectOne=CenterRectOnPoint(rectsize,locations_right(idxLocation_sz2(trial,1),1), locations_right(idxLocation_sz2(trial,1),2));%xy coordinates from current trial
                    rectTwo=CenterRectOnPoint(rectsize,locations_right(idxLocation_sz2(trial,2),1), locations_right(idxLocation_sz2(trial,2),2));%xy coordinates from current trial
                    allrects=[rectOne',rectTwo'];
                case 3                % setsize 3
                    rectOne=CenterRectOnPoint(rectsize,locations_right(idxLocation_sz3(trial,1),1), locations_right(idxLocation_sz3(trial,1),2));%xy coordinates from current trial
                    rectTwo=CenterRectOnPoint(rectsize,locations_right(idxLocation_sz3(trial,2),1), locations_right(idxLocation_sz3(trial,2),2));%xy coordinates from current trial
                    rectThree=CenterRectOnPoint(rectsize,locations_right(idxLocation_sz3(trial,3),1), locations_right(idxLocation_sz3(trial,3),2));%xy coordinates from current trial
                    allrects=[rectOne',rectTwo', rectThree'];
                case 4                % setsize 4
                    rectOne=CenterRectOnPoint(rectsize,locations_right(idxLocation_sz4(trial,1),1), locations_right(idxLocation_sz4(trial,1),2));%xy coordinates from current trial
                    rectTwo=CenterRectOnPoint(rectsize,locations_right(idxLocation_sz4(trial,2),1), locations_right(idxLocation_sz4(trial,2),2));%xy coordinates from current trial
                    rectThree=CenterRectOnPoint(rectsize,locations_right(idxLocation_sz4(trial,3),1), locations_right(idxLocation_sz4(trial,3),2));%xy coordinates from current trial
                    rectFour=CenterRectOnPoint(rectsize,locations_right(idxLocation_sz4(trial,4),1), locations_right(idxLocation_sz4(trial,4),2));%xy coordinates from current trial
                    allrects=[rectOne',rectTwo', rectThree', rectFour'];
                    
            end %switch sz
            
            msgRight = msgHard;
            msgLeft = msgEasy;
            
        case 2 %means easy option right, hard left
            
            rect_sz1 = CenterRectOnPoint(rectsize,locations_right(idxLocation_sz1(trial),1),locations_right(idxLocation_sz1(trial),2));
            
            switch data.sz(trial)
                case 2                 % setsize 2
                    rectOne=CenterRectOnPoint(rectsize,locations_left(idxLocation_sz2(trial,1),1), locations_left(idxLocation_sz2(trial,1),2));
                    rectTwo=CenterRectOnPoint(rectsize,locations_left(idxLocation_sz2(trial,2),1), locations_left(idxLocation_sz2(trial,2),2));
                    allrects=[rectOne',rectTwo'];
                case 3                % setsize 3
                    rectOne=CenterRectOnPoint(rectsize,locations_left(idxLocation_sz3(trial,1),1), locations_left(idxLocation_sz3(trial,1),2));
                    rectTwo=CenterRectOnPoint(rectsize,locations_left(idxLocation_sz3(trial,2),1), locations_left(idxLocation_sz3(trial,2),2));
                    rectThree=CenterRectOnPoint(rectsize,locations_left(idxLocation_sz3(trial,3),1), locations_left(idxLocation_sz3(trial,3),2));
                    allrects=[rectOne',rectTwo', rectThree'];
                case 4                % setsize 4
                    rectOne=CenterRectOnPoint(rectsize,locations_left(idxLocation_sz4(trial,1),1), locations_left(idxLocation_sz4(trial,1),2));
                    rectTwo=CenterRectOnPoint(rectsize,locations_left(idxLocation_sz4(trial,2),1), locations_left(idxLocation_sz4(trial,2),2));
                    rectThree=CenterRectOnPoint(rectsize,locations_left(idxLocation_sz4(trial,3),1), locations_left(idxLocation_sz4(trial,3),2));
                    rectFour=CenterRectOnPoint(rectsize,locations_left(idxLocation_sz4(trial,4),1), locations_left(idxLocation_sz4(trial,4),2));
                    allrects=[rectOne',rectTwo', rectThree', rectFour'];
            end %switch sz
            
            msgRight = msgEasy;
            msgLeft = msgHard;
    end %switch location left right
    
    easyRect = rect_sz1;
    hardRect = allrects;
    
    switch data.condition(trial)
        case 0 % for IGN
            msg = msgIGN;
        case 22 % for UPD
            msg = msgUPD;
    end
    
    %1) Present fixation cross for 1 sec
    drawFixationCross(wPtr, rect);
    Screen('Flip',wPtr);
    WaitSecs(pms.fixation);
    
    %2) Present consideration
    drawFixationCross(wPtr, rect);
%    DrawFormattedText(wPtr,msg,'center','center');
    DrawFormattedText(wPtr,msg,LC(1),LC(2));    %present U or N in centre of squares left
    DrawFormattedText(wPtr,msg,RC(1),RC(2));    %present U or N in centre of squares right
    DrawFormattedText(wPtr,msgLeft,xlength/4-50,ylength*(3/4));
    DrawFormattedText(wPtr,msgRight,xlength*(3/4)-50,ylength*(3/4));
    
    Screen('FrameRect',wPtr, 0, easyRect, 2);
    Screen('FrameRect',wPtr, 0, hardRect, 2);
    
%     offerOnset = Screen('Flip',wPtr);
%     WaitSecs(pms.consideration);
    
    %3) Present choice window
%     choiceOnset = GetSecs; %offerOnset - pms.exptOnset;%double check!!
%     DrawFormattedText(wPtr,msg,'center','center');
%     DrawFormattedText(wPtr,msgLeft,xlength/4-50,ylength*(3/4));
%     DrawFormattedText(wPtr,msgRight,xlength*(3/4)-50,ylength*(3/4));
%     DrawFormattedText(wPtr,msgRespond,'center',ylength*(1/3));
%     
%     Screen('FrameRect',wPtr, 0, easyRect, 2);
%     Screen('FrameRect',wPtr, 0, hardRect, 2);
    
    offerOnset = Screen('Flip',wPtr);
%     imageArray=Screen('GetImage',wPtr);
%     r=randi(100,1);
%     imwrite(imageArray,sprintf('choice%d.png',r),'png');
    choiceOnset = offerOnset - pms.exptOnset;
%     WaitSecs(pms.maxRT);
    WaitSecs(0.001);
    
    responded = [];
    while isempty(responded) && (GetSecs - offerOnset) < pms.maxRT
        % check keyboard
        [keyIsDown, secs, keyCode] = KbCheck;        
        if keyIsDown==1
            % a response has just occurred
            key = KbName(keyCode);% 
            %key = [KbName(keyCode),num2str(evt.state)];
            if any(ismember(key,[pms.allowedResps.left, pms.allowedResps.right]))
                % response was allowable
                responded = 1;
                respTimeStamp = GetSecs;
                choiceRT = secs - offerOnset;
%                 choiceRT = respTimeStamp-choiceOnset;
                if any(ismember(key,[pms.allowedResps.left])) && data.locationEasy(trial)==1;
                    % left key was pressed and easy choice was on left
                    resp = 1;
                    % feedback verifying participant's response
                    Screen('FrameRect',wPtr, 0, FB_left, 2);
                elseif any(ismember(key,[pms.allowedResps.left])) && data.locationEasy(trial)==2;
                    % left key was pressed and easy choice was on right
                    resp = 2;
                    % feedback verifying participant's response
                    Screen('FrameRect',wPtr, 0, FB_left, 2);
                elseif any(ismember(key,[pms.allowedResps.right])) && data.locationEasy(trial)==1;
                    % right key was pressed and easy choice was on left
                    resp = 2;
                    % feedback verifying participant's response
                    Screen('FrameRect',wPtr, 0, FB_right, 2);
                else
                    resp = 1;
                    Screen('FrameRect',wPtr, 0, FB_right, 2);
                end
            end
        end %key is down
        WaitSecs(.001);
    end %while is empty responded
    
    %check to see if participant is too slow
    if isempty(responded);
    resp = 9;
    choiceRT = 0;
    DrawFormattedText(wPtr,'Too slow!','center',ylength*(1/4));
    WaitSecs(pms.iti);
    
        if data.tskAmtTrlNm(trial) < pms.nCalTrials
        i = find(data.hardTask==data.hardTask(trial) & data.tskAmtTrlNm == data.tskAmtTrlNm(trial)+1);
        data.easyOffer(i)=data.easyOffer(trial);
        data.hardOffer(i)=data.hardOffer(trial);
        end
    elseif resp==1 %chose easy
        %follow up steps: define hard and easy offer for next time
        %presenting this option
        if data.tskAmtTrlNm(trial) < pms.nCalTrials
            i = find(data.hardTask==data.hardTask(trial) & data.tskAmtTrlNm == data.tskAmtTrlNm(trial)+1);
            data.easyOffer(i)=data.easyOffer(trial) - data.adjAmt(trial);
            data.hardOffer(i)=data.hardOffer(trial);
            
            if data.easyOffer(i) < 0
                data.easyOffer(i) = 0;
            end
        end
        
    elseif resp==2 %chose hard
        %follow up steps: define hard and easy offer for next time
        %presenting this option
        if data.tskAmtTrlNm(trial) < pms.nCalTrials
        i = find(data.hardTask==data.hardTask(trial) & data.tskAmtTrlNm == data.tskAmtTrlNm(trial)+1);
        data.easyOffer(i)=data.easyOffer(trial) + data.adjAmt(trial);
        data.hardOffer(i)=data.hardOffer(trial);
        end
    end
    
    data.choice(trial) = resp;
    data.choiceRT(trial) = choiceRT;
    data.choiceOnset(trial) = choiceOnset;
    
%     %AGAIN??
    DrawFormattedText(wPtr,msg,LC(1),LC(2));    %present U or N in centre of squares left
    DrawFormattedText(wPtr,msg,RC(1),RC(2));    %present U or N in centre of squares right
    %DrawFormattedText(wPtr,msg,'center','center');
    DrawFormattedText(wPtr,msgLeft,xlength/4-50,ylength*(3/4));
    DrawFormattedText(wPtr,msgRight,xlength*(3/4)-50,ylength*(3/4));
    
    Screen('FrameRect',wPtr, 0, easyRect, 2);
    Screen('FrameRect',wPtr, 0, hardRect, 2);

    drawFixationCross(wPtr, rect);
    Screen('Flip',wPtr,[],1);
%     imageArray=Screen('GetImage',wPtr);
%     r=randi(100,1);
%     imwrite(imageArray,sprintf('choice%d',r),'bmp');
    WaitSecs(0.5);    
    
    %clear screen
     Screen('FillRect',wPtr, 255, rect);
     Screen('Flip',wPtr);
%      imageArray=Screen('GetImage',wPtr);
%     r=randi(100,1);
%     imwrite(imageArray,sprintf('choiceMade%d',r),'bmp');
     WaitSecs(pms.iti);
end %trial loop

end

