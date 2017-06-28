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
wrptx = 60;
spacing = 2;
Screen('TextSize',wPtr,23);
Screen('TextStyle',wPtr,1);
Screen('TextFont',wPtr,'Times New Roman');
   
%% Show first instructions with Screen('DrawText',wPtr,text,x,y,color)
         %Add text that should appear
 
         if level == 1
             
             Instruction{1} = 'Welcome to the choice task. Press any key to continue.';
             Instruction{2} = 'During this part you can win a bonus by redoing a few more blocks of the colorwheel task. However, the difficulty of the redo and the amount of the bonus will be based on choices that you will make beforehand.';
             imgChoice=imread('ChoiceDirect.png');
             imageChoice=Screen('MakeTexture',wPtr,imgChoice);

             Instruction{3}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n For example: Would you rather receive 2 euros for doing Update(U)of 4 squares or 2 euros for doing Ignore(I) of 4 squares?';
             Instruction{4} = sprintf('To select the left option, press 1 and for the right option press 2. You have %d seconds to respond.',pms.maxRT);
             imgChoiceMade=imread('ChoiceMadeDirect.png');
             imageChoiceMade=Screen('MakeTexture',wPtr,imgChoiceMade);
             Instruction{5}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n A square is shown to indicate that your choice has been made';
             Instruction{6} = 'You will make many similar choices, for various amounts and number of squares.';
             Instruction{7} = 'One of these choices will be chosen randomly. The redo of the colorwheel task and the bonus will be based on this choice.';
             Instruction{8}='Press any key to start the practice of this part.\n These choices are not counting yet.';            
             
         elseif level == 2
             Instruction{1}='You will also have the opportunity to avoid doing the redo and still earn a bonus. If you choose the No Redo option, then you can use the remaining time as you please, using the computer, your phone etc.';
             imgChoiceNR=imread('ChoiceNoRedo.png');
             imageChoiceNR=Screen('MakeTexture',wPtr,imgChoiceNR);
             Instruction{2}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n For example: Would you rather receive 2 euros for Ignoring 3 squares or 60 cents for not doing a redo?';
             Instruction{3}='Press any key to start practice for these trials';
         elseif level==3
             Instruction{1}= 'You will make many choices of both types. One of them will be selected and you will redo one to three blocks of the colorwheel task based on that choice. 70% of all trials of the blocks you will do will consist of that choice.';           
             Instruction{2}='The number of blocks of the redo is randomly selected by the computer.';
             Instruction{3}= 'The amount of money of the bonus represents all blocks and not a single trial and it is extra to the agreed amount for the experiment. You will receive it if your performance during the redo is similar to your performance in the first two blocks of the colorwheel task.';
             imgChoiceMade=imread('ChoiceMadeDirect.png');
             imageChoiceMade=Screen('MakeTexture',wPtr,imgChoiceMade);             
             Instruction{4}= '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n For example, if this choice is selected you will do a few blocks of mostly Update 4 and you will earn 2 euros.';
             imgChoiceExample=imread('ChoiceMadeExample2.png');
             imageChoiceExample=Screen('MakeTexture',wPtr,imgChoiceExample);
             Instruction{5}= '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n If this choice is selected you will not have to redo the colorwheel task and you will earn 2 euros.';
             Instruction{6}='Do not rush your answers. It is very important that you think of both the money and your experience of doing the specific trials of the task.';
             Instruction{7}='If something is not clear, do not hesitate to contact the researchers!';
             
         elseif level==4
             Instruction{1} = 'You finished the practice.\n\n You may now proceed with the choice task.';
             Instruction{2}='Good luck!';
             
         elseif level==5
             Instruction{1}='This was the end of the choice task! \n\n Now one of your choices will be selected for the redo.';
         end
         
         for i = 1:length(Instruction)
             if level==1
                 
                 % Exceptions for figures;
                 
                 if i==3
                     Screen('DrawTexture',wPtr,imageChoice)
                     DrawFormattedText(wPtr,Instruction{i},'center','center',textCol,wrptx,[],[],spacing);

                 elseif i==5
                     Screen('DrawTexture',wPtr,imageChoiceMade)
                     DrawFormattedText(wPtr,Instruction{i},'center','center',textCol,wrptx,[],[],spacing);

                 else
                     DrawFormattedText(wPtr,Instruction{i},'center','center',textCol,wrptx,[],[],spacing);

                 end
                 
             elseif level==2
                 if i==2             
                     Screen('DrawTexture',wPtr,imageChoiceNR)
                     DrawFormattedText(wPtr,Instruction{i},'center','center',textCol,wrptx,[],[],spacing);

                 else
                     DrawFormattedText(wPtr,Instruction{i},'center','center',textCol,wrptx,[],[],spacing);

                 end
                     
             elseif level==3
                 if i==4
                     Screen('DrawTexture',wPtr,imageChoiceMade)
                     DrawFormattedText(wPtr,Instruction{i},'center','center',textCol,wrptx,[],[],spacing);

                 elseif i==5
                     Screen('DrawTexture',wPtr,imageChoiceExample)
                     DrawFormattedText(wPtr,Instruction{i},'center','center',textCol,wrptx,[],[],spacing);

                 else
                     DrawFormattedText(wPtr,Instruction{i},'center','center',textCol,wrptx,[],[],spacing);

                 end
                 
             elseif  level==4 || level==5
                 
                 DrawFormattedText(wPtr,Instruction{i},'center','center',textCol,wrptx,[],[],spacing);

             end
              Screen('flip',wPtr);
                     KbWait()
                     %         imageArray=Screen('GetImage',wPtr);
%         r=randi(100,1);
%         imwrite(imageArray,sprintf('InstructionsChoice%d.png',r),'png');

             %record the keyboard click
             responded = 0;
             while responded == 0
                  RestrictKeysForKbCheck([pms.allowedResps.left, pms.allowedResps.right,37,39,32,97,98])
                 [keyIsDown] = KbCheck;
                 if keyIsDown==1
                     WaitSecs(1);
                     responded = 1;
                 end
             end
             RestrictKeysForKbCheck([])
         end
         %  clear Screen
         
         
         
         
         %                 %Wacht op het indrukken van de muis toets voordat het verder gaat
         %
         %
         %                 % collect response, checking both mouse and keyboard
         % responded = 0;
         % while responded==0
         %
         %     if ~isempty(mouseresp) % check mouse
         %         [x, y, buttons] = GetMouse(wid);
         %         secs = GetSecs;
         %         if (any(buttons))
         %             responseMatches = any(ismember(num2str(find(buttons)),mouseresp));
         %             if strcmp(mouseresp,'any') || responseMatches
         %                 responded = 1;
         %                 resp = num2str(find(buttons));
         %                 rt = secs - onset_stamp;
         %             end
         %         end
         %     end
         %     WaitSecs(.001);
         % end
         
         
