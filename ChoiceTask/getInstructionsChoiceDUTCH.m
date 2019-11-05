function getInstructionsChoiceDUTCH(level,pms,wPtr)
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
    
    Instruction{1} = 'Welkom bij de keuze experiment!\n U kunt door de instructies gaan met de linker- en rechterpijltoetsen.\n Klik op de rechterpijltoets om verder te gaan.';
    Instruction{2} = 'Tijdens dit onderdeel willen we zien hoeveel moeite het u kost om de Update of de Negeer taak opnieuw te doen. We bieden u twee opties met kleine beloningen (geldbedrag) voor het herhalen van een experiment en u kiest degene die u leuker vindt! We willen weten welk aanbod U beter vindt. ';    
    imgChoice=imread('ChoiceSZDUTCH.png');
    imageChoice=Screen('MakeTexture',wPtr,imgChoice);   
    Instruction{3}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Voorbeeld: Zou u liever 1 euro ontvangen voor de UPDATE (U) taak met 1 vierkant of zou u liever 2 euro ontvangen voor de UPDATE (U) taak met 3 vierkant?';
    Instruction{4} = sprintf('Om de linker optie te selecteren, drukt u op 1 en om de rechter optie te selecteren drukt u op 2.');
    imgChoiceMade=imread('ChoiceMadeSZDUTCH.png');
    imageChoiceMade=Screen('MakeTexture',wPtr,imgChoiceMade);
    Instruction{5}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Een vierkant wordt getoond om aan te geven dat u een keuze heeft gemaakt.';
    Instruction{6} = 'We zullen u veel vergelijkbare aanbiedingen laten zien en u moet elke keer kiezen welk aanbod u accepteert.';
    Instruction{7} = 'Uiteindelijk kiest de computer willekeurig een van de aanbiedingen die u hebt geaccepteerd. U zult de taak geassocieerd met dat aanbod moeten herhalen en ontvangt ook de aangeboden beloning.';
    Instruction{8}='Druk op een toets om de oefenversie van dit onderdeel te starten.\n Deze keuzes worden nog niet meegerekend.';
    
elseif level == 2
    Instruction{1}='Daarnaast heeft u soms ook de keuze om geen enkele taak opnieuw te doen en toch een beloning te krijgen. Bij deze keuze kunt u de overgebleven tijd in deze onderzoeksruimte zelf indelen.';
    imgChoiceNR=imread('ChoiceNoRedoDUTCH.png');
    imageChoiceNR=Screen('MakeTexture',wPtr,imgChoiceNR);
    Instruction{2}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n BIJVOORBEELD: Zou u liever 2 euro ontvangen voor de NEGEER (N) taak met 1 vierkant of 60 eurocent ontvangen en geen taak doen?';
    Instruction{3}='Druk op een toets om de oefenversie te starten.';
elseif level==3
    Instruction{1}= 'U zult dus veel keuzes maken. Soms moet u kiezen tussen twee taken, soms tussen een taak en geen taak. Van al uw keuzes zal er een worden geselecteerd en u zult deze taak 15 minuten lang opnieuw uitvoeren.';
    Instruction{2}= 'Als u een taak opnieuw gaat doen maar niet altijd nauwkeurig antwoord dan zult u de beloning ontvangen zolang u goed uw best blijft doet.' ;
    imgChoiceMade=imread('ChoiceMadeExample1DUTCH.png');
    imageChoiceMade=Screen('MakeTexture',wPtr,imgChoiceMade);
    Instruction{3}= '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n BIJVOORBEELD: als deze keuze is geselecteerd doet u voornamlijk de NEGEER (N) taak met 3 vierkanten en ontvangt u 2.00 euro.';
    imgChoiceExample=imread('ChoiceMadeExample2DUTCH.png');
    imageChoiceExample=Screen('MakeTexture',wPtr,imgChoiceExample);
    Instruction{4}= '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n BIJVOORBEELD: als deze keuze is geselecteerd dan hoeft u geen taak te herhalen en ontvangt u 1.60 euro.';
    Instruction{5}='Geef geen gehaaste antwoorden. Het is erg belangrijk dat u denkt aan het geld en aan uw ervaring met het doen van de specifieke taak (NEGEER/ UPDATE) en de moeilijkheidniveaus ( 1/ 3 vierkanten).';
    Instruction{6}='Het is heel belangrijk dat u kiest wat u echt leuk vindt en niet wat u denkt dat we willen dat u kiest!';
    Instruction{7}='Als iets onduidelijk is, aarzel dan niet om het aan de onderzoekers te vragen!';
    
elseif level==4
    Instruction{1} = 'U hebt de oefenversie volbracht.\n\n U mag nu doorgaan met de keuze experiment.';
    Instruction{2}='Veel succes!';
    
elseif level==5
    Instruction{1}='Dit was het einde van de keuze experiment! \n\n Nu zal een van uw keuzes worden geselecteerd voor de herhaling van de kleurenwiel experiment.';
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
        if counter==3
            Screen('DrawTexture',wPtr,imageChoiceMade)
            DrawFormattedText(wPtr,Instruction{counter},'center','center',textCol,wrptx,[],[],spacing);
            
        elseif counter==4
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


