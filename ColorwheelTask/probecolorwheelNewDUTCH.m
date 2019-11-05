function [respX,respY,rt,colortheta,respXAll,respYAll,rtAll,rtMovement,rtDecision]=probecolorwheelNewDUTCH(pms,allRects,probeRectX,probeRectY,practice,probeColorCorrect,lureColor,g,p,varargin)
% function that gives the colorwheel for the task and the probe of the colorwheel memory task
% Takes as inputs the amount of colors displayed on the wheel, the X Y coordinates
% of the probe rect and the maxRT possible. Colorwheel is constructed by
% two Rects. One is the wheel and the other an oval shape that masks the
% center of the wheel. The coordinates are related to each screen. The
% colors are created with arcs. Arc's size is reversely analogous
% to number of colors used. By default,the first arc starts at vertical and adds
% on clockwise until the circle is completed. We introduce a shift every
% trial so that the colorwheel orientation changes. Colortheta is a struct with
% the angle of every color in the wheel and the corresponding color. 
% 
% SYNTAX
% [respX,respY,rt,colortheta]=probecolorwheel2(pms,probeRectX,probeRectY,practice,probeColorCorrect,wheelStart)
% respX                x coordinates of response
% respY                y coordinates of response
% rt                   response time
% colortheta           struct with angles and corresponding colors on the colorwheel
% 
% pms                  parameters defined in main script BeautifulColorwheel.m
% probeRectX            x coordinate of center of probed rectangle, input from showtrial.m function
% probeRectY            y coordinate of center of probed rectangle, input from showtrial.m function
% practice              1 for practice, 0 for actual task, input from getInfo.m
% probeColorCorrect     color participants needed to remember, input from showtrial.m
% lureColor             lure color (intervening for I, encoding for U),input from showtrial.m
% wheelStart            begining of arc (0 degrees)
% 
% 
% functions called        [respDif,tau,thetaCorrect,radius]=respDev(colortheta,probeColorCorrect,respX,respY)
%                         drawFixationCross(pms.wPtr,rect)
% respDev provides the angle of the response made by the participant,the correct angle, the deviance
% of the response from the correct color and the radius of the circle created by the response of 
% the participant. We need the radius to estimate if they clicked on the colorwheel.
% 
% drawFixationCross displays the fixation cross in the center of the screen.


%coordinates in outer circle of wheel, so we can estimate radius
% wheelRadiusX=611; 
% wheelRadiusY=113;

%center coordinates
centerX=pms.rect(3)/2;
centerY=pms.rect(4)/2;
%show mouse and place it in the center of the screen
ShowCursor('Arrow');
SetMouse(centerX,centerY,pms.wPtr);

%feedback messages
messageLate='Reageer sneller!';
messageWrong='Klik op het kleurenwiel!';
messageColor=[0 0 0];
%Thickness of response arc
lineThickness=0.4;
lineColor=[0 0 0];

probeThickness=3;

probeColor=[0 0 0];
%rects that form the colorwheel are proportional of screen size
probeRect=[100 100 200 200];
insideRect=[pms.rect(1) pms.rect(2) 0.67*pms.rect(4) 0.67*pms.rect(4)]; %the white oval coordinates
outsideRect=[pms.rect(1) pms.rect(2) 0.9*pms.rect(4) 0.9*pms.rect(4)]; %the wheel coordinates
insideRectColor=pms.background;
%center all rects 
outsideRect=CenterRectOnPoint(outsideRect,centerX, centerY);
insideRect=CenterRectOnPoint(insideRect,centerX,centerY);
probeRect=CenterRectOnPoint(probeRect,probeRectX,probeRectY);

%define colors in RGB values
colors=hsv(pms.numWheelColors)*255;

%each arc represents one color and shapes a circle
colorangle=360/length(colors);  

%We want to shift the orientation of the colorwheel in every trial so we use an offset. To keep
%it same for every participant we save the offset and load it: starts=randi(360,pms.numTrials,pms.numBlocks)
switch nargin
    case 9
        load starts
        wheelStart=starts(g,p);
    case 10
        trial=varargin{1};
        wheelStart=trial(g,p).wheelStart;
end
%defines locations of every color arc
wheelAngles=wheelStart:colorangle:360+wheelStart;

%theta represents the angle for every color
 theta=zeros(length(colors),1);
       for index=1:length(colors)   
           theta(index)=(360*index)/length(colors);
       end
% colortheta is a structure with number of Colors fields linking "color" to "angle" of presentation
 
colortheta=struct; 

for n=1:length(colors)
   colortheta(n).color=colors(n,:); %pick color n from all colors
   colortheta(n).theta=theta(n)+wheelStart;    %pick angle n from all angles and add initial shift (wheelStart)
end


% Colorwheel 
for ind=1:length(colors)
  Screen('FillArc',pms.wPtr,colors(ind,:),outsideRect,wheelAngles(ind),colorangle);
end

 %ring created with inside circle
  Screen('FillOval',pms.wPtr,insideRectColor,insideRect);
%all rectangles
Screen('FrameRect',pms.wPtr,probeColor,allRects)
%probed rectangle 
Screen('FrameRect', pms.wPtr, probeColor, probeRect,probeThickness)
drawFixationCross(pms.wPtr,pms.rect)


probeOnset = Screen('Flip',pms.wPtr);
%%%% response collected by coordinates of mouse click
%show and set the mouse in the center

%                           imageArray=Screen('GetImage',pms.wPtr);
%                           imwrite(imageArray,sprintf('Probe%d.png',g,p),'png');


% mousePress=0; %indication of no response
respXAll=[];
respYAll=[];
rtAll=[];
movement=0;
response=0;
while GetSecs-probeOnset<pms.maxRT %while they did not make a response during the probe response duration
    [~, secs, ~] = KbCheck;
    [x,y,buttons]=GetMouse(pms.wPtr);
                radiusWheel      = sqrt((x-centerX)^2+(y-centerY)^2);                

    if radiusWheel>25
        startResponse=GetSecs;
        rtDecision=startResponse-probeOnset;
        movement=1;
            
    mousePress=any(buttons);%response was made
    
    %first response counts, all are recorded
    if mousePress
        respXAll=[respXAll;x];
        respYAll=[respYAll;y];
        rtAll=[rtAll;secs-probeOnset];
        respX=respXAll(1);
        respY=respYAll(1);
        rt=rtAll(1);
        rtMovement=rt-startResponse;
        [respDif,tau,thetaCorrect,radius]=respDev(colortheta,probeColorCorrect,lureColor,respX,respY,pms.rect); %90 for red responses around 0
        
        for ind=1:length(colors)
            Screen('FillArc',pms.wPtr,colors(ind,:),outsideRect,wheelAngles(ind),colorangle);
        end
        
        %Response indication: if they didn't click on the fixation cross (radius~=0) or within the inner circle, a line appears indicating
        %their choice
        if ~isnan('tau')
            if radius>abs(insideRect(1)-insideRect(3))/2
                Screen('FillArc',pms.wPtr,lineColor,outsideRect,tau-lineThickness/2,lineThickness/2); %response indication arc
                Screen('FillOval',pms.wPtr,insideRectColor,insideRect)
                Screen('FrameRect',pms.wPtr,probeColor,allRects)
                Screen('FrameRect', pms.wPtr, probeColor, probeRect,probeThickness)
                drawFixationCross(pms.wPtr,pms.rect)
                Screen('Flip',pms.wPtr)
                %                   WaitSecs(pms.feedbackDuration)
            end
        end
        %Even if they made response they have to wait maxRT secs.
        %                 WaitSecs(pms.maxRT-rt)
    end  
    end %if mousePress
    WaitSecs(0.1);
end %while (mousePress==0...)

HideCursor();

%% Feedback
% if respX exists participants responded
if exist('respX','var')
    %during practice a second line appears indicating the correct response. The line is
    %drawn as a small arc of 0.4 degrees
    if practice==1 && radius>abs(insideRect(1)-insideRect(3))/2
        for ind=1:length(colors)
            Screen('FillArc',pms.wPtr,colors(ind,:),outsideRect,wheelAngles(ind),colorangle);
        end
        %their response
        Screen('FillArc',pms.wPtr,lineColor,outsideRect,tau-lineThickness/2,lineThickness/2);
        Screen('FillArc',pms.wPtr,lineColor,outsideRect,thetaCorrect-lineThickness/2,lineThickness/2);
        Screen('FillOval',pms.wPtr,insideRectColor,insideRect);
        Screen('FrameRect',pms.wPtr,probeColor,allRects)
        Screen('FrameRect', pms.wPtr, probeColor, probeRect,probeThickness)
        
        %feedback if they are +-10 degrees from target color
        if abs(respDif) <=10
            Screen('TextSize',pms.wPtr,20);
            message=sprintf('Goed bezig! \n U week slechts %d graden af van het correcte antwoord.',abs(round(respDif)));
            DrawFormattedText(pms.wPtr, message, 'center', 'center', messageColor);
        else
            %otherwise no feedback
            drawFixationCross(pms.wPtr,pms.rect)
        end
        Screen('Flip',pms.wPtr)
        WaitSecs(pms.feedbackDurationPr);
    end %if practice=1
    %if they clicked in the inner circle or on the fixation cross they receive feedback to click on the
    %colorwheel
%     if isnan(tau)|| radius<abs(insideRect(1)-insideRect(3))/2
%         for ind=1:length(colors)
%             Screen('FillArc',pms.wPtr,colors(ind,:),outsideRect,wheelAngles(ind),colorangle);
%         end
%         Screen('FillOval',pms.wPtr,insideRectColor,insideRect);
%         Screen('TextSize',pms.wPtr,18);
%         DrawFormattedText(pms.wPtr, messageWrong, 'center', 'center', messageColor);
%         Screen('Flip',pms.wPtr)
%         WaitSecs(pms.feedbackDuration);
%     end
    
%%if the participant did not respond respX does not exist, so respX, respY and rt
%are set to NaN. They receive feedback to respond faster. 
elseif ~exist('respX','var')
    
    respX=NaN;
    respY=NaN;
    rt=NaN;
    rtMovement=NaN;
    rtDecision=NaN;

    for ind=1:length(colors)
        Screen('FillArc',pms.wPtr,colors(ind,:),outsideRect,wheelAngles(ind),colorangle);
    end
    Screen('FillOval',pms.wPtr,insideRectColor,insideRect);
    Screen('TextSize',pms.wPtr,18);
    DrawFormattedText(pms.wPtr, messageLate, 'center', 'center', messageColor);
    Screen('Flip',pms.wPtr)
    WaitSecs(pms.feedbackDuration);
    
end
end
              
                        


      




