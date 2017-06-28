function [nameData]=ColorNaming(pms)

global wPtr rect
% Screen('Preference', 'VisualDebugLevel',0);
% Screen('Preference','SkipSyncTests',1); 
% Screen('Preference', 'SuppressAllWarnings', 1);
% 
% [wPtr,rect]=Screen('Openwindow',max(Screen('Screens')));

 [~,pie]=sampledColorMatrix(pms);
                       
%depending on number of trials, we first sample from the middle, then the 
%edges of the Pie  
centerX=rect(3)/2;
centerY=rect(4)/2;
rectOne=[0 0 100 100];
rectOne=CenterRectOnPoint(rectOne,centerX,centerY-200);

index=randperm(pms.NameTrials);

for N=1:pms.NameTrials

    if index(N)<=12
        probePie=pie(index(N)).color;
        namePie=pie(index(N)).name;
     
    elseif index(N)>12
        probePie=pie(index(N)-12).color;
        namePie=pie(index(N)-12).name;
        
    elseif index(N)>24
        probePie=pie(index(N)-24).color;
        namePie=pie(index(N)-24).name;
      
    end
probeColor=datasample(probePie,1);

Screen('TextSize',wPtr,25);
Screen('TextStyle',wPtr,0);
Screen('FillRect', wPtr, probeColor, rectOne'); 
DrawFormattedText(wPtr, 'How would you name the above color?','center', centerY-100, [0 0 0])
reply=Ask(wPtr,'Please type your response and press enter',[],[],'GetString','center','center',15);
DrawFormattedText(wPtr, reply, 'center', centerY+100, [0 0 0])
Screen('Flip',wPtr)
WaitSecs(2)
  
NamesData(N).probeColor=probeColor;
NamesData(N).respName=reply;
NamesData(N).pie=probePie;
NamesData(N).pieName=namePie;

end
 %clear Screen
filename=sprintf('NamesTest_s%d_pilot2.mat',pms.subNo);
                         
if exist (filename,'file')
    randAttach = round(rand*10000);
    filename = strcat(filename, sprintf('_%d.mat',randAttach));  
end
                          
save(filename,'NamesData')

end

                          