% FEEDBACKCOMMON - provide feedback for button press / keyboard tasks

function thistrial = feedbackCommon(r,e,thistrial,RT,firstpressed,options,experimentdata)

thistrial.hitTarget = find(firstpressed==options);
if isempty(thistrial.hitTarget)
    thistrial.hitTarget = 0;
end

if RT<0
    thistrial.successful = -5;
    thistrial.questSuccess = -1;
    thistrial.playsound = 1;
    writetolog(e,'Too early');
    thistrial.responseText = experimentdata.texts.TOO_EARLY;
elseif thistrial.hitTarget == 0
    thistrial.successful = -4;
    thistrial.questSuccess = -1;
    thistrial.playsound = 1;
    writetolog(e,'No button pressed');
    thistrial.responseText = experimentdata.texts.TOO_SLOW;
elseif thistrial.hitTarget == thistrial.targetNum
    thistrial.successful=1;
    thistrial.questSuccess = 1;
    writetolog(e,['Succesful to target' num2str(thistrial.hitTarget)]);
    thistrial.responseText = experimentdata.texts.SUCCESS;
else
    thistrial.successful = 0;
    thistrial.questSuccess = 0;
    writetolog(e,['Wrong direction (correct = ' num2str(thistrial.targetNum) ')']);
    thistrial.responseText = experimentdata.texts.WRONG;
end
