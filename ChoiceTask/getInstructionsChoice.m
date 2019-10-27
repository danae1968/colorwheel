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
    
    Instruction{1} = 'Welcome to the choice game!\n You can walk through the instructions by using the left and right arrow keys.\n Press right arrow to start...';
    Instruction{2} = 'During this part we want to see how much it costs to you to repeat the Ignore and the Update task of the colorwheel game. We will offer you monetary rewards for repeating the task and you get to accept the one you like more! \n We are interested in what feels like a better offer to you.';
    imgChoice=imread('ChoiceDirect.png');
    imageChoice=Screen('MakeTexture',wPtr,imgChoice);
    
    Instruction{3}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Example offers: Would you rather receive 2 euros for repeating the Ignore(I) task of 3 squares or 1 euro for repeating the Ignore(I) for 1 square?';
    Instruction{4} = sprintf('To select the left option you can press 1 and for the right option you can press 2. You have %d seconds to respond.',pms.maxRT);
    imgChoiceMade=imread('ChoiceMadeDirect.png');
    imageChoiceMade=Screen('MakeTexture',wPtr,imgChoiceMade);
    Instruction{5}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n A square is shown to indicate that your choice has been recorded';
    Instruction{6} = 'We will show you many similar offers and you have to choose which you accept every time.';
    Instruction{7} = 'In the end, the computer will randomly pick one of the offers you accepted; you will have to repeat that offer and you will also receive the bonus!';
    Instruction{8}='Press any key to start the practice of this part.\n These choices are not counting yet.';
    
elseif level == 2
    Instruction{1}='Sometimes, we will also give you the offer to not repeat any task and still earn a monetary reward. The "No Task" option means that you could use the remaining time as you please.';
    imgChoiceNR=imread('ChoiceNoRedo.png');
    imageChoiceNR=Screen('MakeTexture',wPtr,imgChoiceNR);
    Instruction{2}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Example offers: Would you rather receive 2 euros doing the Ignore task with 1 square or 60 cents for not repeating any task?';
    Instruction{3}='Press any key to start practice for these trials';
elseif level==3
    Instruction{1}= 'After you have accepted many of our offers, the computer will select one randmoly and present it on the screen.';
    Instruction{2}='If you have to repeat one of the tasks, the task you chose (ignore/update) will consist of 70% of the trials. \n When you replay the game, you do not have to always be accurate to receive the bonus, as long as you try to do your best';
    Instruction{3}= 'If you accepted the "no task" offer, you can do whatever you want with the rest of your time here!'; 
    imgChoiceMade=imread('ChoiceMadeExample1.png');
    imageChoiceMade=Screen('MakeTexture',wPtr,imgChoiceMade);
    Instruction{4}= '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n For example, if this choice is selected you will do a few blocks of mostly Update 1 and you will earn 2 euros.';
    imgChoiceExample=imread('ChoiceMadeExample2.png');
    imageChoiceExample=Screen('MakeTexture',wPtr,imgChoiceExample);
    Instruction{5}= '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n If this choice is selected you will not have to redo the colorwheel task and you will earn 1.40 euros.';
    Instruction{6}= 'What is really important for our research is to measure your preferences, so please accept the offers that appeal to you most!';
    Instruction{6}='Please do not rush your answers. It is very important that you think of both the money and your experience of doing the specific task (Ignore/Update) and difficulty (one or three squares).';
    Instruction{7}='Let us know if you have any questions!';
    
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


