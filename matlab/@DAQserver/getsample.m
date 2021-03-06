% GETSAMPLE - get the latest sample of data
% [data,framenumber] = getsample(o,nummarkers)
%
% It should produce a 1xN array of data

function [data,framenumber] = getsample(d,nummarkers)

if nargin<2 || isempty(nummarkers)
    nummarkers = 3;
end

% Get the latest data from the DAQ card
result = getdata(d.t);

if d.sampletype==2
    data(2:nummarkers+1) = sign(bitand(result,uint16(power(2,0:nummarkers-1))));
else
    data(2:nummarkers+1) = result;
end

% These is no timing information returned, so use getSecs 
framenumber = GetSecs;

data = double(data);
data(1) = framenumber;