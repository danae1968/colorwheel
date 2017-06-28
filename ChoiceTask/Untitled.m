   Screen('Preference','SkipSyncTests', 1);
    Screen('Preference', 'VBLTimestampingMode', -1);
    Screen('Preference','TextAlphaBlending',0);
    Screen('Preference', 'VisualDebugLevel',0);  
[wPtr,rect]=Screen('Openwindow',max(Screen('Screens')));

for n=[ 99]
imageNeg=importdata(sprintf('choice%d',n));
Screen('PutImage', wPtr, imageNeg)
Screen('Flip',wPtr)
KbWait
end
clear Screen