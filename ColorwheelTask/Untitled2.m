clear all
Screen('Preference','SkipSyncTests', 1);
    Screen('Preference', 'VBLTimestampingMode', -1);
    Screen('Preference','TextAlphaBlending',0);
    Screen('Preference', 'VisualDebugLevel',0);
        [wPtr,rect]=Screen('Openwindow',max(Screen('Screens')));
respX=[];
respY=[];
rt=[];
    pms.maxRT=5;
                      drawFixationCross(wPtr,rect)
                      Screen('Flip',wPtr)
                      probeOnset=GetSecs;
                      
  while GetSecs-probeOnset<pms.maxRT
     [~, secs, ~] = KbCheck;
     [x,y,buttons]=GetMouse(wPtr);
     
    mousePress=any(buttons);
  
  
  if mousePress
        respX=[respX;x];
        respY=[respY;y];
        rt=[rt;secs-probeOnset];
  end
  WaitSecs(0.1);
  end

  clear Screen