function getInstructionsDUTCH(level,pms,wPtr)
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
    
    Instruction{1} = 'Welkom. Dit is de zogeheten kleurenwiel taak.\n U kunt de instructies doorlopen met de linker- en rechterpijltoetsen.\n Druk op de rechterpijltoets om de taak te starten...';
    Instruction{2} = 'Deze taak bestaat steeds uit 3 delen. Eerst moet u kleuren en locaties onthouden. Dan ziet u nieuwe kleuren die u misschien moet onthouden. Daarna wordt uw geheugen getest op het kleurenwiel!';
    Instruction{3} =sprintf('Deel 1: u ziet een gekleurd vierkant en de letter H (HERINNER) op het scherm.\n Het vierkant zal worden getoond gedurende %.1f seconden.',pms.encDuration);
    Instruction{4} = 'U moet altijd de kleur en de locatie van het vierkant onthouden.';
    imgEnc=imread('EncodingDUTCH.png');
    imageEnc=Screen('MakeTexture',wPtr,imgEnc);
    Instruction{5}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Deel 1: HERINNER (H) de kleur en locatie.';
    Instruction{6} = 'Deel 1:\n U herinnert telkens de kleur en locatie van het vierkant. \n\n Deel 2:\n U zult een ander vierkant zien in dezelfde locatie.\n Het nieuwe vierkant zal worden getoond samen met een letter in het midden van het scherm. Deze letter kan een I of een U zijn.';
    Instruction{7} = 'Deze letter is erg belangrijk omdat het u zal vertellen wat u hierna moet doen.\n Als het een N is, moet u het nieuwe vierkant NEGEREN\n en doorgaan met het onthouden van het vierkant uit stap 1.';
    imgIgnore=importdata('IgnoreDUTCH.png');
    imageIgnore=Screen('MakeTexture',wPtr,imgIgnore);
    Instruction{8}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Deel 2: NEGEER dit vierkant.';
    Instruction{9} = 'Maar als de letter een V (VERVANGEN)is, dan moet u ALLEEN het nieuwe vierkant in deel 2 onthouden.';
    imgUpdate=importdata('UpdateDUTCH.png');
    imageUpdate=Screen('MakeTexture',wPtr,imgUpdate);
    Instruction{10}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Deel 2: Onthoud dit vierkant in uw geheugen.' ;
    Instruction{11} = sprintf('Deel 1:\n U herinnert telkens de kleur en locatie van het vierkant.\n\n Deel 2:\n Als de letter in het midden een N is:\n dan NEGEERT u de nieuwe kleur in deel 2.\n Als de letter in het midden een V is:\n dan Vervangen u uw geheugen met alleen het nieuwe vierkant.\n\n Deel 3:\n U ziet een kleurenwiel en de rand van een vierkant zonder kleur.\n U moet met de computermuis in het kleurenwiel aangeven welke kleur u diende te onthouden.\n U heeft %d seconden om te reageren.',pms.maxRT);
    imgProbe=importdata('Probe.png');
    imageProbe=Screen('MakeTexture',wPtr,imgProbe);
    Instruction{12}='Klik op de correcte kleur!\n (Nu nog niet, dit is slechts een voorbeeld!)';
    Instruction{13}='Alleen uw eerste antwoord telt. Probeer altijd een antwoord te geven ook als u hiervan niet zeker bent. Probeer daarnaast om zo snel en zo nauwkeurig mogelijk te reageren. Houd uw hand op de computermuis zodat u voldoende tijd heeft om te reageren.';
    Instruction{14}='Probeer om tijdens de taak altijd naar het scherm te kijken.';
    Instruction{15} ='Samenvattend: \n\n Deel 1:\n U herinnert telkens de kleur en locatie van het vierkant.\n\n Deel 2:\n Als de letter in het midden een N is:\n dan NEGEERT u de nieuwe kleur in deel 2.\n Als de letter in het midden een V is:\n dan Vervangen u uw geheugen met alleen het nieuwe vierkant.\n\n Deel 3: In het kleurenwiel geeft u aan welke kleur u moest herinneren.';
    Instruction{16} = 'We beginnen met slechts 1 vierkant per keer, maar dit kan oplopen tot 3 vierkanten.\n Wanneer meerdere kleuren te zien zijn, probeer dan om alle kleuren en bijbehorende locaties te onthouden.\n\n';
    Instruction{17}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Deel 1 met 3 kleuren';
    imgEnc3=importdata('Encsz3DUTCH.png');
    imageEnc3=Screen('MakeTexture',wPtr,imgEnc3);
    Instruction{18}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Deel 2 met 3 kleuren';
    imgUpdate3=importdata('Update3DUTCH.png');
    imageUpdate3=Screen('MakeTexture',wPtr,imgUpdate3);
    Instruction{19}='Van alle 3 de kleuren die u moet aangeven \n onthoud alleen de kleur van het uitgelichte vierkant.';
    Instruction{20}='';
    imgProbe3=importdata('ProbeSZ3.png');
    imageProbe3=Screen('MakeTexture',wPtr,imgProbe3);
        if pms.trackGaze
        Instruction{21}='Tijdens deze taak zullen we u oogbewegingen volgen.';
    Instruction{22}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Voordat ieder nieuw deel van de taak begint, ziet u een zwart punt.';
    imgSignal=importdata('Signal.png');    
    imageSignal=Screen('MakeTexture',wPtr,imgSignal);
            Instruction{23}='Blijf alstublieft naar de punt kijken. \n Als de taak na een paar seconden nog niet is gestart, druk dan op spatie en blijf naar de stip kijken.';

    Instruction{24} = 'Is alles duidelijk?\n\n Het is erg belangrijk dat u dit onderdeel begrijpt. Wij begrijpen dat het in het begin verwarrend kan zijn.\n Maak a.u.b. contact met de onderzoekers, zij zullen de oefening pas starten als al uw vragen zijn beantwoordt.';
        else 
            Instruction{21}='\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Voordat ieder nieuw deel van de taak begint, ziet u een zwart punt.';
    imgSignal=importdata('Signal.png');    
    imageSignal=Screen('MakeTexture',wPtr,imgSignal);
        Instruction{22} = 'Is alles duidelijk?\n\n Het is erg belangrijk dat u dit onderdeel begrijpt. Wij begrijpen dat het in het begin verwarrend kan zijn.\n Maak a.u.b. contact met de onderzoekers, zij zullen de oefening pas starten als al uw vragen zijn beantwoordt.';

        end
elseif level == 2
    
    Instruction{1} = 'Dit was het einde van de oefening.\n\n U kunt nu beginnen met de echte taak.';
    Instruction{2}='Tijdens de echte taak krijgt u geen terugkoppeling (2e lijn) over uw antwoorden.';
    Instruction{3}=sprintf('We delen de taak in %d blokken. \n\n Na ieder blok kunt u een pauze nemen of doorgaan met de taak.',pms.numBlocks);
    Instruction{4}='Succes met de kleurenwiel geheugen taak!';
    
elseif level ==3
    %
    Instruction{1}='Einde van de oefening.';
    
elseif level==4
    
    Instruction{1}='Dit is het einde van de kleurenwiel geheugen taak! \n\n Neem contact op met de onderzoekers.';
    
elseif level==5
    
    switch pms.choiceCondition
        case 0
            Instruction{1}=sprintf('De geselecteerde keuze is Negeer %d voor %d euro. U zult een blok van de kleurenwiel taak opnieuw doen.',pms.choiceSZ,pms.bonus);
        case 2
            Instruction{1}=sprintf('De geselecteerde keuze is Vervangen %d voor %d euro. U zult een blok van de kleurenwiel taak opnieuw doen.',pms.choiceSZ,pms.bonus);
    end
            
elseif level==6
    Instruction{1}='Dit was het einde van het experiment! \n\n Bedankt voor uw deelname.\n\n Neem contact op met de onderzoekers.';
    
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
