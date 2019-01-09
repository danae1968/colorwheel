function getInstructions(level,pms,wPtr)
% % This function provides the instructions for the
% % colorwheel memory task based on which phase of the experiment we are
% % (practice, begining, end). If level is 1 then it provides the detailed
% % instructions for the task, if level is 2 the actual task starts, level 3
% % informs about the end of practice and level 4 about the end of the
% % memory task.
% %
% SYNTAX
%
% GETINSTRUCTIONS(level,pms,wPtr)
% level:    phase of the experiment we need instructions for (1: begin practice, 2: begin task, 3: end practice, 4: end task)
% pms:      parameteres defined in main script. Here we use parameters pms.yCenter (middle of y axis of screen), pms.textColor (color of text)and pms.wrapAt (where to wrap the text).
% wPtr:     monitor (given as output in main script by PTB function  [wPtr,rect]=Screen('Openwindow',max(Screen('Screens')));)
%
%

%Hide mouse during instructions
HideCursor;

%% Text for level 1. Every cell is a different screen.

if level == 1
    
    Instruction{1} = 'Welcome to our colorwheel memory task.\n You can walk through the instructions by using the left and right arrow keys.\n Press right arrow to start...';
    Instruction{2} = 'Every trial of this task consists of 3 phases. First, you will have to memorize colors and locations. Then, you see new colors that you might need to memorize. Finally you are tested on our colorwheel!';
    Instruction{3} =sprintf('Phase 1: you will see a colored square and the letter "M" (memorize) on the screen.\n The square will be shown for %.1f seconds.',pms.encDuration);
    Instruction{4} = 'You always need to memorize the color and the location of the square.';
    imgEnc=imread('Encoding.png');
    imageEnc=Screen('MakeTexture',wPtr,imgEnc);
    Instruction{5}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Phase 1: memorize (M) color and location.';
    Instruction{6} = 'Phase 1:\n You always MEMORIZE the color and location of the square.\n\n Phase 2:\n You will see another square at the same location.\n The new square will also be accompanied by a letter in the middle of the screen. The letter can be I or U.';
    Instruction{7} = 'The letter is very important because it tells you what to do next.\n If the letter is I, you need to ignore the new square\n and continue to keep in memory the one from phase 1.';
    imgIgnore=importdata('Ignore.png');
    imageIgnore=Screen('MakeTexture',wPtr,imgIgnore);
    Instruction{8}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Phase 2: Ignore this square.';
    Instruction{9} = 'But if the letter is U, you need to remember ONLY the new square presented in phase 2.';
    imgUpdate=importdata('Update.png');
    imageUpdate=Screen('MakeTexture',wPtr,imgUpdate);
    Instruction{10}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Phase 2: Update this square to your memory.' ;
    Instruction{11} = sprintf('Phase 1:\n You always MEMORIZE the color and location of the square.\n\n Phase 2:\n If the letter in the centre is I:\n you IGNORE the new color in phase 2.\n If the letter in the centre is U:\n you UPDATE your memory with ONLY the new square.\n\n Phase 3:\n You see a colorwheel and the frame of a square without color.\n You need to indicate with a mouse click on the wheel, which color you needed to remember.\n You have %d seconds to respond.',pms.maxRT);
    imgProbe=importdata('Probe.png');
    imageProbe=Screen('MakeTexture',wPtr,imgProbe);
    Instruction{12}='Click on the correct color!\n (Not now, this is an example!)';
    Instruction{13}='Only your first response counts. Please try to respond always, even if you are not certain, and try to be as accurate and fast as possible. Keep your hand on the mouse so that you have enough time to respond.';
    Instruction{14}='Please try to always look at the screen while doing the task.';
    Instruction{15} ='Summary: \n\n Phase 1:\n You always MEMORIZE the color and location of the square.\n\n Phase 2:\n If the letter in the centre is I:\n you IGNORE the new color in phase 2.\n If the letter in the centre is U:\n you UPDATE your memory with ONLY the new square.\n\n Phase 3: On the colorwheel you indicate which color you needed to remember.';
    Instruction{16} = 'We start with one square being presented at a time, but increase it to 3.\n When multiple colors are presented, try to memorize all colors and the according locations.\n\n';
    Instruction{17}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Phase 1 with 3 colors';
    imgEnc3=importdata('Encsz3.png');
    imageEnc3=Screen('MakeTexture',wPtr,imgEnc3);
    Instruction{18}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Phase 2 with 3 colors';
    imgUpdate3=importdata('Update3.png');
    imageUpdate3=Screen('MakeTexture',wPtr,imgUpdate3);
    Instruction{19}='Of all 3 colors you need to indicate \n only the color of the HIGHLIGHTED square.';
    Instruction{20}='';
    imgProbe4=importdata('ProbeSZ3.png');
    imageProbe3=Screen('MakeTexture',wPtr,imgProbe3);
    Instruction{21}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Before every new trial you will see a black dot.';
    imgSignal=importdata('Signal.png');    
    imageSignal=Screen('MakeTexture',wPtr,imgSignal);
    Instruction{22} = 'Is everything clear?\n\n It is very important that you understand this part well and we realize that it might be confusing in the beginning.\n Please make contact with the researchers, they will start the practice when all questions are addressed..';
    
elseif level == 2
    
    Instruction{1} = 'You finished the practice.\n\n You may now proceed with the actual task.';
    Instruction{2}='During the actual memory task, you will not receive feedback (2nd line) for your answers.';
    Instruction{3}=sprintf('We split the task in %d blocks. \n\n After every block you can take a break or continue with the task.',pms.numBlocks);
    Instruction{4}='Good luck with the memory task!';
    
elseif level ==3
    %
    Instruction{1}='End of practice!';
    
elseif level==4
    
    Instruction{1}='This is the end of the colorhweel memory task! \n\n Please contact the researchers.';
    
elseif level==5
    
    switch pms.choiceCondition
        case 0
            Instruction{1}=sprintf('The selected choice is Ignore %d for %d euros. You will redo one block of the colorwheel task.',pms.choiceSZ,pms.bonus);
        case 2
            Instruction{1}=sprintf('The selected choice is Update %d for %d euros. You will redo one block of the colorwheel task.',pms.choiceSZ,pms.bonus);
    end
            
elseif level==6
    Instruction{1}='This was the end of the experiment! \n\n Thank you for your participation.\n\n Please contact the researchers.';
    
end %level
counter=1;
for i=1:100
    RestrictKeysForKbCheck([37,39,40,38,32,97,98])
    if i==1
        back=0;
    end
    if counter<length(Instruction)
        counter=counter+back;
    end
    
    if level==1
        % Exceptions for figures;
        switch counter
            case 5
                Screen('DrawTexture', wPtr, imageEnc)
            case 8
                Screen('DrawTexture', wPtr, imageIgnore)
            case 10
                Screen('DrawTexture', wPtr, imageUpdate)
            case 12
                Screen('DrawTexture', wPtr, imageProbe)
            case 17
                Screen('DrawTexture', wPtr, imageEnc3)
            case 18
                Screen('DrawTexture', wPtr, imageUpdate3)
            case 20
                Screen('DrawTexture',wPtr,imageProbe3)
            case 21 
                Screen('DrawTexture',wPtr,imageSignal)
        end
        if counter==12
            DrawFormattedText(wPtr,Instruction{counter},'center',pms.yCenter-90,pms.textColor,pms.wrapAt,[],[],pms.spacing);
        else
            DrawFormattedText(wPtr,Instruction{counter},'center','center',pms.textColor,pms.wrapAt,[],[],pms.spacing);
        end
    end %level
    
    if level~=1
        DrawFormattedText(wPtr,Instruction{counter},'center','center',pms.textColor,pms.wrapAt,[],[],pms.spacing);
    end
    
    Screen('flip',wPtr);
    %         imageArray=Screen('GetImage',wPtr);
    %         r=randi(100,1);
    %         imwrite(imageArray,sprintf('InstructionColorwheel%d',r),'bmp');
    
    
    if level==1 && counter==length(Instruction)
        GetClicks()
        break
    elseif counter==length(Instruction)
        KbWait();
        break
    else 
        KbWait();
        
    end
    
    %      %record the keyboard click
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
            
        end %level
    end %find keyCode
end %if key is down
RestrictKeysForKbCheck([])
%  clear Screen

end

