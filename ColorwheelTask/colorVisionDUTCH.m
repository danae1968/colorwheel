function [colorTestData]=colorVisionDUTCH(pms)

%%%function that shows randomly selected colors and checks for color
%%%perception

Screen('Preference', 'VisualDebugLevel',0);
Screen('Preference','SkipSyncTests',1); 
Screen('Preference', 'SuppressAllWarnings', 1);

[wPtr,rect]=Screen('Openwindow',max(Screen('Screens')));


Screen('TextSize',wPtr,24);
Screen('TextStyle',wPtr,1);
Screen('TextFont',wPtr,'Times New Roman');

numTrials=pms.colorTrials;
rectOne=[0 0 100 100];
centerX=rect(3)/2;
centerY=rect(4)/2;
ShowCursor('Arrow'); %we can change the shape of the mouse and then type ShowCursor(newcursor) %MF: wow, that's cool!!
SetMouse(rect(3)/2,rect(4)/2,wPtr);
testOnset=GetSecs();
wrptx=rect(3)/4;
message='Welkom bij de geheugen taak!\n\n\n Voordat we gaan beginnenen gaan we uw gevoeligheid voor kleuren controleren. \n\n In het midden van het scherm zult u een gekleurd vierkant zien.\n\n Vind de bijbehorende kleur op het kleurenwiel en klik erop!\n\n Probeer zo nauwkeurig mogelijk te zijn, maar neem niet te veel tijd om te reageren!\n\n\n Dit is geen gevalideerde kleurgevoeligheidstest. Deze is alleen relevant voor ons experiment.\n\n Druk op spatie om te starten.';
passingScore=15;

DrawFormattedText(wPtr, message,'center','center',[],wrptx)
Screen('Flip',wPtr)
KbWait()

insideRect=[rect(1) rect(2) 0.67*rect(4) 0.67*rect(4)]; %the white oval coordinates
outsideRect=[rect(1) rect(2) 0.9*rect(4) 0.9*rect(4)]; %the wheel coordinates
rectOne=CenterRectOnPoint(rectOne,centerX,centerY);
outsideRect=CenterRectOnPoint(outsideRect,centerX, centerY);
insideRect=CenterRectOnPoint(insideRect,centerX,centerY);

%define colors
colors=hsv(pms.numWheelColors)*255;
colorangle=360/length(colors);  
[~,pie]=sampledColorMatrix(pms);

                       %depending on number of trials, we first
                          %sample from the middle, then the edges of
                          %the Pie  
                          index=randperm(numTrials);                     
                      for N=1:numTrials
                          
                      if index(N)<=12
                          probePie=pie(index(N)).color;
                          namePie=pie(index(N)).name;
                          numberPie=pie(index(N)).number;
                          probeColorCorrect=probePie(round(length(probePie)/2),:);
                          colorPosition=1;
                      elseif index(N)>12
                          probePie=pie(index(N)-12).color;
                          namePie=pie(index(N)-12).name;
                          numberPie=pie(index(N)-12).number;
                          probeColorCorrect=probePie(1,:);
                          colorPosition=0;
                      elseif index(N)>24
                          probePie=pie(index(N)-24).color;
                          namePie=pie(index(N)-24).name;
                          probeColorCorrect=probePie(end,:);         
                          numberPie=pie(index(N)-24).number;                          
                          colorPosition=2;
                      end

                      load starts.mat
                      wheelStart=starts(N);
                      startangle=wheelStart:colorangle:360+wheelStart;  
                      
                      for ind=1:length(colors)
                          Screen('FillArc',wPtr,colors(ind,:),outsideRect,startangle(ind),colorangle);
                      end

                      Screen('FillOval',wPtr,pms.background,insideRect);
                      Screen('FillRect', wPtr, probeColorCorrect, rectOne'); 

                      Screen('Flip',wPtr)
%                           r=randi(100);
%                             imageArray=Screen('GetImage',wPtr);
%                             imwrite(imageArray,sprintf('ColTest%d.png',r),'png');
                     probeOnset=GetSecs();

                         [~, secs] = KbCheck;
                         %waits for a click and records
                         [clicks,x,y]=GetClicks(wPtr);
                         if any(clicks)
                            respX=x;
                            respY=y;
                            rt=secs-probeOnset;
                         end
                         
                         WaitSecs(0.001);

% clear Screen

%theta represents the angle for every color
 theta=zeros(length(colors),1);
       for ind=1:length(colors)   
           theta(ind)=(360*ind)/length(colors);
       end

       % colortheta is a structure with number of Colors fields linking "color" to "angle" of presentation
 
colortheta=struct; 

for n=1:length(colors)
   colortheta(n).color=colors(n,:); %pick color n from all colors
   colortheta(n).theta=theta(n)+wheelStart;    %pick angle n from all angles and add initial shift (wheelStart)
end
       
                lureColor=probePie(2,:); %don't need it here
               [respDif,tau,thetaCorrect,radius]=respDev(colortheta,probeColorCorrect,lureColor,respX,respY,rect);
               
    for ind=1:length(colors)
        Screen('FillArc',wPtr,colors(ind,:),outsideRect,startangle(ind),colorangle);
    end

      if ~isnan('tau')
             if radius>abs(insideRect(1)-insideRect(3))/2
      Screen('FillArc',wPtr,[0 0 0],outsideRect,tau-0.2,0.2);
%           Screen('FillArc',wPtr,[0 0 0],outsideRect,thetaCorrect-0.2,0.2);
      Screen('FillOval',wPtr,pms.background,insideRect);
       Screen('FillRect', wPtr, probeColorCorrect, rectOne'); 
      Screen('Flip',wPtr);
       WaitSecs(0.5);

      for ind=1:length(colors)
        Screen('FillArc',wPtr,colors(ind,:),outsideRect,startangle(ind),colorangle);
      end
      Screen('FillArc',wPtr,[0 0 0],outsideRect,tau-0.2,0.2);
      Screen('FillArc',wPtr,[0 0 0],outsideRect,thetaCorrect-0.2,0.2);
      Screen('FillOval',wPtr,pms.background,insideRect);


      if abs(respDif) <=10
              Screen('TextSize',wPtr,18);
        message2=sprintf('Goed bezig! \n U week slechts %d graden af van het correcte antwoord.',abs(round(respDif)));
        DrawFormattedText(wPtr, message2, 'center', 'center', [0 0 0]);
         else
      %otherwise no feedback
      end
         Screen('Flip',wPtr)
%                                 r=randi(1000);
%                             imageArray=Screen('GetImage',wPtr);
%                             imwrite(imageArray,sprintf('ColTest%dFeedback.png',r),'png');   
         WaitSecs(0.8);
             end
      end

         colorTestData(N).respDif=abs(respDif);  
         colorTestData(N).respDifDirection=respDif;           
         colorTestData(N).rt=rt;
         colorTestData(N).probeColor=probeColorCorrect;
%              colorTestData(N).colorName=reply;
         colorTestData(N).pie=probePie;
         colorTestData(N).pieName=namePie;
         colorTestData(N).pieNumber=numberPie;
         colorTestData(N).colorPosition=colorPosition;


                      end  %for N=1:numTrials
                      %for index=randperm(numTrials)
                      filename=sprintf('ColorTest_s%d.mat',pms.subNo);

                      if exist (filename,'file')
                            randAttach = round(rand*10000);
                            filename = strcat(filename, sprintf('_%d.mat',randAttach));  
                      end
                       save(fullfile(pms.colordir,filename),'colorTestData')

meanScore=mean([colorTestData.respDif]);

for ind=1:length(colors)
    Screen('FillArc',wPtr,colors(ind,:),outsideRect,startangle(ind),colorangle);
end
    Screen('FillOval',wPtr,pms.background,insideRect);

if meanScore>passingScore
  DrawFormattedText(wPtr, 'Het spijt ons, maar u heeft de test niet gehaald. Wilt u het nog een keer proberen?','center','center',[],wrptx)
  Screen('Flip',wPtr)
  WaitSecs(5)
  clear Screen
elseif meanScore<=passingScore
  DrawFormattedText(wPtr, 'Gefeliciteerd! U heeft de test gehaald.\n U kunt nu doorgaan met de rest van het experiment.','center','center',[],wrptx)
  Screen('Flip',wPtr)
  KbWait()
end

% clear Screen
end