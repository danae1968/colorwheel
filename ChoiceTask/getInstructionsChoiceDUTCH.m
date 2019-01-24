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
    
    Instruction{1} = 'Welkom bij de keuze taak!\n U kunt door de instructies gaan met de linker- en rechterpijltoetsen.\n Klik op de rechterpijltoets om te starten...';
    Instruction{2} = 'Tijdens dit onderdeel kunt u een bonus krijgen wanneer u een paar extra blokken van de kleurenwiel taak opnieuw doet. Echter, de moeilijkheid hiervan en de bijbehorende bonus zal worden gebaseerd op keuzes die de door u gemaakte keuzes.';
    imgChoice=imread('ChoiceDirectDUTCH.png');
    imageChoice=Screen('MakeTexture',wPtr,imgChoice);
    
    Instruction{3}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Bijvoorbeeld: Zou u liever 2 euro ontvangen voor het NEGEREN (N) van 4 vierkanten of zou u liever 2 euro ontvangen voor het VERVANGEN (V) van 4 vierkanten?';
    Instruction{4} = sprintf('Om de linker optie te selecteren, druk op 1 en om de rechter optie te selecteren druk op 2. U heeft %d seconden om te reageren.',pms.maxRT);
    imgChoiceMade=imread('ChoiceMadeDirectDUTCH.png');
    imageChoiceMade=Screen('MakeTexture',wPtr,imgChoiceMade);
    Instruction{5}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Een vierkant wordt getoond om aan te geven dat u een keuze heeft gemaakt.';
    Instruction{6} = 'U zult veel dezelfde keuzes maken,voor meedere keren en meerdere vierkanten.';
    Instruction{7} = 'Een van deze keuzes zal willekeurig worden gekozen. The herhaling van enkele blokken van de kleurenwiel taak en de bijbehorende bonus zal worden gebaseerd op deze keuze.';
    Instruction{8}='Druk op een toets om de oefening van dit onderdeel te starten.\n Deze keuzes worden nog niet meegerekend.';
    
elseif level == 2
    Instruction{1}='Daarnaast heeft u ook de mogelijkheid om de herhaling niet te doen en toch een bonus te krijgen. Deze optie houdt in dat u de overgebleven tijd in de onderzoeksruimte zelf mag indelen.';
    imgChoiceNR=imread('ChoiceNoRedoDUTCH.png');
    imageChoiceNR=Screen('MakeTexture',wPtr,imgChoiceNR);
    Instruction{2}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Bijvoorbeeld: Zou u liever 2 euro ontvangen voor het NEGEREN (N) van 4 vierkanten of 60 eurocent ontvangen voor het NIET OPNIEUW doen van een blok van de kleurenwiel taak?';
    Instruction{3}='Druk op een toets om de oefenversie te starten.';
elseif level==3
    Instruction{1}= 'U zult veel keuzes van beide soorten maken. Een van de twee zal worden geselecteerd en u zult 1 tot 3 blokken van de kleurenwiel taak opnieuw uitvoeren gebaseerd op uw keuze. Ieder blok duurt ongeveer 15 minuten.';
    Instruction{2}='Het aantal blokken van het opnieuw doen is willekeurig bepaald door de computer.';
    Instruction{3}= 'De hoeveelheid geld van de bonus is een aanvulling op het overeengekomen bedrag voor dit experiment. U zult dit ontvangen als uw prestatie tijdens de herhaling gelijk is aan uw presteren in de eerste twee blokken van de kleurenwiel taak. Dat houdt in dat als u de bonus wilt ontvangen, u moeite moet steken in deze taak maar niet zoveel dat u heel nauwkeurig hoeft te zijn.';
    imgChoiceMade=imread('ChoiceMadeExample1DUTCH.png');
    imageChoiceMade=Screen('MakeTexture',wPtr,imgChoiceMade);
    Instruction{4}= '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Bijvoorbeeld: als deze keuze is geselecteerd doet u een paar blokken van bijna allemaal negeer 1 en u ontvangt 2 euro.';
    imgChoiceExample=imread('ChoiceMadeExample2DUTCH.png');
    imageChoiceExample=Screen('MakeTexture',wPtr,imgChoiceExample);
    Instruction{5}= '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Als deze keuze is geselecteerd dan hoeft u niet een herhaling van de kleurenwiel taak te doen en ontvangt u 1.00 euro.';
    Instruction{6}='Geef geen gehaaste antwoorden. Het is erg belangrijk dat u denk aan het geld en aan uw ervaring met het doen van de specifieke oefeningen van de taak(d.w.z. het aantal vierkanten en Negeren (N) / Vervangen (V) condities).';
    Instruction{7}='Als iets onduidelijk is, aarzel dan niet om het aan de onderzoekers te vragen!';
    
elseif level==4
    Instruction{1} = 'U hebt de oefenversie volbracht.\n\n U mag nu doorgaan met de keuze taak.';
    Instruction{2}='Veel succes!';
    
elseif level==5
    Instruction{1}='Dit was het einde van de keuze taak! \n\n Nu zal een van uw keuzes worden geselecteerd voor de herhaling van de kleurenwiel taak.';
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


