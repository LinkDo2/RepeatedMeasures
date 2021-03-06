% GENERATEMALEFEMALEPROTOCOL - generate the protocol for the MaleFemale experiment
%
% generateMaleFemaleProtocol

function generateMaleFemaleProtocol

filename = 'protocols/MaleFemale.xml';
experimentDescription = [];

experimentDescription.setup.monitorWidth = 70; %cm
experimentDescription.setup.viewingDistance = 68; %cm
experimentDescription.setup.xshift = 0; % relative shift of fixation / targets

experimentDescription.setup.framerate = 30;

experimentDescription.setup.keyboard.server = 'localhost';
experimentDescription.setup.keyboard.port = 3002;
experimentDescription.common.targetType.keyboard.keytopress = {'z','m'}; % (z for left, m for right)
experimentDescription.common.starttrial = 'keyboard'; % start trials by pressing space bar

experimentDescription.setup.images = {'Female1.png','Female2.png','Male1.png','Male2.png','cb.png'};

numrepetitions = 2;

targets = [repmat(1,1,numrepetitions)...
           repmat(2,1,numrepetitions)...
           repmat(3,1,numrepetitions)...
           repmat(4,1,numrepetitions)];

correct = [repmat(1,1,numrepetitions*2) repmat(2,1,numrepetitions*2)];

% randomly reorder 
neworder = randperm(numel(targets));

n=1;
experimentDescription.trial{n}.stimulus.showText.text = {'z for female, m for male'};
experimentDescription.trial{n}.recording = 0;
experimentDescription.trial{n}.recordingTime = 0;

for m=1:numel(targets)
    n = n+1;
    experimentDescription.trial{n}.stimulus.images.stimuli = [targets(neworder(m)) 1 Inf 0];
    experimentDescription.trial{n}.targetNum = correct(neworder(m));
    experimentDescription.trial{n}.recordingTime = 3;
    experimentDescription.trial{n}.textFeedback = 1;
    experimentDescription.trial{n}.filename = sprintf('%d_%d',correct(neworder(m)),targets(neworder(m)));
end

tree = struct2xml(experimentDescription);
save(tree,filename);

% load the protocol file and validate it
e = experiment(filename,'testData');
validate(e);
