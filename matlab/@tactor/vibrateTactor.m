% VIBRATETACTOR - vibrate the given tactors for a certain duration
% vibrateTactorCommand(t,tactorNumbers,duration)
%
% tactorNumbers  - array of tactors to vibrate (e.g. 1, [1 2], etc). First tactor is number 1
% duration - duration to vibrate, in ms

function vibrateTactor(t,tactorNumbers,duration)

command = vibrateTactorCommand(tactorNumbers,duration);

sendmessage(t,command);
pause(0.1);
readACK(t);