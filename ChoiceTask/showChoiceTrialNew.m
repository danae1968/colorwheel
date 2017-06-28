function [data] = showChoiceTrialNew(pms, data, wPtr,rect, dataFilenamePrelim,blockType)

%%%% setup at the beginning of a trial

%% What we need
% 1) general locations on screen
xlength = rect(3); %screen length x
ylength = rect(4); %screen height y
%define left centre (LC) and right centre (RC)
LC = [xlength/4, ylength/2];
RC = [xlength*(3/4), ylength/2];
rectsizeFB = [0 0 250 250];
rectsizeC= [0 0 xlength/1.2 ylength/1.5];
FB_left = CenterRectOnPoint(rectsizeFB,LC(1)+60,LC(2));
FB_right = CenterRectOnPoint(rectsizeFB,RC(1)-40,RC(2));
rect_Center=CenterRectOnPoint(rectsizeC,xlength/2,ylength/2);

% 3) locations of squares
% give and fine tune offset of centre
offset = 100; %offset (symmetrical)
locations_left = [LC + [-offset -offset]; LC + [offset -offset]; LC + [offset offset]; LC + [-offset offset]];
locations_right = [RC + [-offset -offset]; RC + [offset -offset]; RC + [offset offset]; RC + [-offset offset]];

% 4) text on screen while choice
msgUPD = 'Update';
msgIGN = 'Ignore';


%% Stimulus presentation starts here
for trial = 1:length(data.trialNumber)

    if trial == 1 || data.block(trial) - data.block(trial-1) == 1

        
        save(dataFilenamePrelim.dataFilenamePrelim)

    
    end %if
    
    msgHard = sprintf('for €%.2f',data.hardOffer(trial));
    msgEasy = sprintf('for €%.2f',data.easyOffer(trial));
    
    switch data.locationEasy(trial)
        case 1 %means easy option left, hard right
            
            switch data.hardTask(trial)
                case 1                 % setsize 2
                    if blockType==1
                        msgTypeL='No Redo';
                    elseif blockType==2 
                         msgTypeL='Ignore 1';
                    elseif blockType==3
                        msgTypeL='Update 1';
                    end
                    
                    if blockType==3
                        msgTypeR='Ignore 1';
                    else                        
                        msgTypeR='Ignore 2';
                    end

                  
                case 2                % setsize 3
                    if blockType==1
                        msgTypeL='No Redo';
                    elseif blockType==2
                        msgTypeL='Ignore 1';
                    elseif blockType==3
                        msgTypeL='Update 2';
                    end
                    
                    if blockType==3
                    msgTypeR='Ignore 2';
                    else
                    msgTypeR='Ignore 3';
                    end

                case 3                % setsize 4
                    if blockType==1
                        msgTypeL='No Redo';
                    elseif blockType==2
                        msgTypeL='Ignore 1';
                    elseif blockType==3
                        msgTypeL='Update 3';
                    end
                    if blockType==3
                        msgTypeR='Ignore 3';
                    else
                        msgTypeR='Ignore 4';
                    end

                case 4
                    if blockType==1
                        msgTypeL='No Redo';
                    elseif blockType==2
                        msgTypeL='Update 1';
                    elseif blockType==3
                        msgTypeL='Update 4';
                    end
                    if blockType==3
                        msgTypeR='Ignore 4';
                    else
                        msgTypeR='Update 2';
                    end

                case 5
                    if blockType==1
                        msgTypeL='No Redo';
                    elseif blockType==2
                        msgTypeL='Update 1';
                    end
                    msgTypeR='Update 3';

                case 6
                    if blockType==1
                        msgTypeL='No Redo';
                    elseif blockType==2
                        msgTypeL='Update 1';
                    end
                    msgTypeR='Update 4';
                    
                case 7
                    msgTypeL='No Redo';
                    msgTypeR='Ignore 1';
                case 8
                    msgTypeL='No Redo';
                    msgTypeR='Update 1';

            end %switch hardTask
            
            msgRight = msgHard;
            msgLeft = msgEasy;
            
        case 2 %means easy option right, hard left
            
               switch data.hardTask(trial)
                case 1                 % setsize 2
                    if blockType==1
                        msgTypeR='No Redo';
                    elseif blockType==2
                        msgTypeR='Ignore 1';
                    elseif blockType==3
                        msgTypeR='Update 1';
                    end
                    if blockType==3
                        msgTypeL='Ignore 1';
                    else
                        msgTypeL='Ignore 2';
                    end

                  
                case 2                % setsize 3
                    if blockType==1
                        msgTypeR='No Redo';
                    elseif blockType==2
                        msgTypeR='Ignore 1';
                    elseif blockType==3
                        msgTypeR='Update 2';
                    end
                    if blockType==3
                        msgTypeL='Ignore 2';
                    else
                        msgTypeL='Ignore 3';
                    end

                case 3                % setsize 4
                    if blockType==1
                        msgTypeR='No Redo';
                    elseif blockType==2
                        msgTypeR='Ignore 1';
                    elseif blockType==3
                        msgTypeR='Update 3';
                    end
                    if blockType==3
                        msgTypeL='Ignore 3';
                    else
                        msgTypeL='Ignore 4';
                    end

                case 4
                    if blockType==1
                        msgTypeR='No Redo';
                    elseif blockType==2
                        msgTypeR='Update 1';
                    elseif blockType==3
                        msgTypeR='Update 4';
                    end
                    if blockType==3
                        msgTypeL='Ignore 4';
                    else
                        msgTypeL='Update 2';
                    end

                case 5
                    if blockType==1
                        msgTypeR='No Redo';
                    elseif blockType==2
                        msgTypeR='Update 1';
                    end
                    msgTypeL='Update 3';

                case 6
                    if blockType==1
                        msgTypeR='No Redo';
                    elseif blockType==2
                        msgTypeR='Update 1';
                    end
                    msgTypeL='Update 4';
                case 7
                    msgTypeR='No Redo';
                    msgTypeL='Ignore 1';
                case 8
                    msgTypeR='No Redo';
                    msgTypeL='Update 1';

            end %switch hardTask
           
            msgRight = msgEasy;
            msgLeft = msgHard;
    end %switch location left right
    

drawFixationCross(wPtr, rect);
DrawFormattedText(wPtr,msgTypeR , RC(1)-100,RC(2)-60);
DrawFormattedText(wPtr,msgRight, RC(1)-100,RC(2));
DrawFormattedText(wPtr,msgTypeL, LC(1),LC(2)-60);
DrawFormattedText(wPtr, msgLeft, LC(1),LC(2));
Screen('FrameRect',wPtr,[0 0 0],rect_Center);

        offerOnset = Screen('Flip',wPtr);
%    imageArray=Screen('GetImage',wPtr);
%     r=randi(100,1);
%     imwrite(imageArray,sprintf('newChoice%d.png',r),'png');
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
        data.easyOffer(i)=data.easyOffer(trial)+ data.adjAmt(trial) ;
        data.hardOffer(i)=data.hardOffer(trial);
                  
        end
    end
    
    data.choice(trial) = resp;
    data.choiceRT(trial) = choiceRT;
    data.choiceOnset(trial) = choiceOnset;
    
%     %AGAIN??
DrawFormattedText(wPtr,msgTypeR , RC(1)-100,RC(2)-60);
DrawFormattedText(wPtr,msgRight, RC(1)-100,RC(2));
DrawFormattedText(wPtr,msgTypeL, LC(1),LC(2)-60);
DrawFormattedText(wPtr, msgLeft, LC(1),LC(2));
    Screen('FrameRect',wPtr,[0 0 0],rect_Center);
    drawFixationCross(wPtr, rect);
    Screen('Flip',wPtr,[],1);
%     imageArray=Screen('GetImage',wPtr);
%     r=randi(100,1);
%     imwrite(imageArray,sprintf('ChoiceMade%d.png',r),'png');
    WaitSecs(0.5);    
    
    %clear screen
     Screen('FillRect',wPtr, 255, rect);
     drawFixationCross(wPtr, rect);
     Screen('FrameRect',wPtr,[0 0 0],rect_Center);

     Screen('Flip',wPtr);
%      imageArray=Screen('GetImage',wPtr);
%     r=randi(100,1);
%     imwrite(imageArray,sprintf('choiceMade%d',r),'bmp');
     WaitSecs(pms.iti);
end %trial loop

end

