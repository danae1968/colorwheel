function getInstructionsChoice(level,pms,wPtr)
%%%This function provides the insturctions for the
%%%Quantifying cognitive control experiment. As inputs it receives level (1=memory, 2=discounting),
%%encTime is the time they have to memorize squares during encoding and
%%maxRT the time they have to respond using the colorwheel.


% % Priority(1); %Give matlab/PTB processes high priority
HideCursor;
% level=1;
% encTime=2;
% maxRT=4;
% open an onscreen window
% Screen('Preference','SkipSyncTests',1);
% Screen('Preference', 'SuppressAllWarnings', 1);
% [wPtr]=Screen('Openwindow',max(Screen('Screens')));

%% Centering

%screenWidth = rect(3);
%screenHeight = rect(4);
%screenCenterX = screenWidth/2;
%screenCenterY = screenHeight/2;

%% Define which text style to use for instructions

%         Screen('TextSize',wPtr, 32);            %determine size of text
%         Screen('TextFont',wPtr, 'Helvetica');   %Which font has the text
%         Screen('TextStyle',wPtr, 1);
% wid = 10;
textCol = [0 0 0];
wrptx = 75;
spacing = 2.5;
Screen('TextSize',wPtr,23);
Screen('TextStyle',wPtr,1);
Screen('TextFont',wPtr,'Times New Roman');

%% Show first instructions with Screen('DrawText',wPtr,text,x,y,color)
%Add text that should appear

if level == 1
    
    Instruction{1} = 'Welcome to the choice task!\n You can walk through the instructions by using the left and right arrow keys.\n Press right arrow to start...';
    Instruction{2} = 'During this part you can win a bonus by redoing a few more blocks of the colorwheel task. However, the difficulty of the redo and the amount of the bonus will be based on choices that you will make beforehand.';
    imgChoice=imread('ChoiceDirect.png');
    imageChoice=Screen('MakeTexture',wPtr,imgChoice);
    
    Instruction{3}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n For example: Would you rather receive 2 euros for doing Ignore(I) of 4 squares or 2 euros for doing Update(U) of 4 squares?';
    Instruction{4} = sprintf('To select the left option, press 1 and for the right option press 2. You have %d seconds to respond.',pms.maxRT);
    imgChoiceMade=imread('ChoiceMadeDirect.png');
    imageChoiceMade=Screen('MakeTexture',wPtr,imgChoiceMade);
    Instruction{5}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n A square is shown to indicate that your choice has been made';
    Instruction{6} = 'You will make many similar choices, for various amounts and number of squares.';
    Instruction{7} = 'One of these choices will be chosen randomly. The redo of the colorwheel task and the bonus will be based on this choice.';
    Instruction{8}='Press any key to start the practice of this part.\n These choices are not counting yet.';
    
elseif level == 2
    Instruction{1}='You will also have the opportunity to avoid doing the redo completely and still earn a bonus.The No Redo option means that you could use the remaining time as you please in the cubicle, using the computer, your phone etc.';
    imgChoiceNR=imread('ChoiceNoRedo.png');
    imageChoiceNR=Screen('MakeTexture',wPtr,imgChoiceNR);
    Instruction{2}='\n\n\n\n\n\n\n\n\n\n\n\n\n For example: Would you rather receive 2 euros for Ignoring 4 squares or 60 cents for not doing a redo?';
    Instruction{3}='Press any key to start practice for these trials';
elseif level==3
    Instruction{1}= 'You will make many choices of both types. One of them will be selected and you will redo one to three blocks of the colorwheel task based on that choice. Each block lasts about 15min. 70% of all trials of the blocks you will do will consist of that choice.';
    Instruction{2}='The number of blocks of the redo is randomly selected by the computer.';
    Instruction{3}= 'The amount of money of the bonus represents all blocks and not a single trial and it is extra to the agreed amount for the experiment. You will receive it if your performance during the redo is similar to your performance in the first two blocks of the colorwheel task. That means that to earn the bonus you would need to put effort in doing the task, but not that you would always have to be accurate.';
    imgChoiceMade=imread('ChoiceMadeExample1.png');
    imageChoiceMade=Screen('MakeTexture',wPtr,imgChoiceMade);
    Instruction{4}= '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n For example, if this choice is selected you will do a few blocks of mostly Update 1 and you will earn 2 euros.';
    imgChoiceExample=imread('ChoiceMadeExample2.png');
    imageChoiceExample=Screen('MakeTexture',wPtr,imgChoiceExample);
    Instruction{5}= '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n If this choice is selected you will not have to redo the colorwheel task and you will earn 1.40 euros.';
    Instruction{6}='Do not rush your answers. It is very important that you think of both the money and your experience of doing the specific trials of the task (i.e. number of squares and Ignore (I) /Update (U) condition).';
    Instruction{7}='If something is not clear, do not hesitate to contact the researchers!';
    
elseif level==4
    Instruction{1} = 'You finished the practice.\n\n You may now proceed with the choice task.';
    Instruction{2}='Good luck!';
    
elseif level==5
    Instruction{1}='This was the end of the choice task! \n\n Now one of your choices will be selected for the redo.';
end

counter=1;

for i=1:100
    RestrictKeysForKbCheck([pms.allowedResps.left, pms.allowedResps.right,37,39,40,38,32,97,98])
    if i==1
        back=0;
    end
    if counter<length(Instruction)
        counter=counter+back;
    end
    
    if level==1
        
        % Exceptions for figures;
        
        if counter==3
            Screen('DrawTexture',wPtr,imageChoice)
            DrawFormattedText(wPtr,Instruction{counter},'center','center',textCol,wrptx,[],[],spacing);
            
        elseif counter==5
            Screen('DrawTexture',wPtr,imageChoiceMade)
            DrawFormattedText(wPtr,Instruction{counter},'center','center',textCol,wrptx,[],[],spacing);
            
        else
            DrawFormattedText(wPtr,Instruction{counter},'center','center',textCol,wrptx,[],[],spacing);
            
        end
        
    elseif level==2
        if counter==2
            Screen('DrawTexture',wPtr,imageChoiceNR)
            DrawFormattedText(wPtr,Instruction{counter},'center','center',textCol,wrptx,[],[],spacing);
            
        else
            DrawFormattedText(wPtr,Instruction{counter},'center','center',textCol,wrptx,[],[],spacing);
            
        end
        
    elseif level==3
        if counter==4
            Screen('DrawTexture',wPtr,imageChoiceMade)
            DrawFormattedText(wPtr,Instruction{counter},'center','center',textCol,wrptx,[],[],spacing);
            
        elseif counter==5
            Screen('DrawTexture',wPtr,imageChoiceExample)
            DrawFormattedText(wPtr,Instruction{counter},'center','center',textCol,wrptx,[],[],spacing);
            
        else
            DrawFormattedText(wPtr,Instruction{counter},'center','center',textCol,wrptx,[],[],spacing);
            
        end
        
    elseif  level==4 || level==5
        
        DrawFormattedText(wPtr,Instruction{counter},'center','center',textCol,wrptx,[],[],spacing);
        
    end
    Screen('flip',wPtr);
    KbWait()
    if counter==length(Instruction)
        break
    end
    %         imageArray=Screen('GetImage',wPtr);
    %         r=randi(100,1);
    %         imwrite(imageArray,sprintf('InstructionsChoice%d.png',r),'png');
    
    %record the keyboard click
    responded = 0;
    while responded == 0
        [keyIsDown,~,KeyCode] = KbCheck;
        if keyIsDown==1
            WaitSecs(1);
            responded = 1;
            if find(KeyCode)==37 && counter~=1
                back=-1;
            else
                back=1;
            end
            
        end
    end
end
RestrictKeysForKbCheck([])

%  clear Screen


