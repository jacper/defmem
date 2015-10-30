clear all

%% SET UP SUBJECTS, PATHS AND INITIALIZE
% define subjects
subjects    = [99];
nSubs       = length(subjects);
nObjects    = 8;


%define paths
inPth = '/home/memspa/jacbel/_defmem/behaviour/UDK_logs/';  % change this to the directory where you save your logfiles!
% outPth = '/home/memspa/jacbel/_defmmem/behaviour/navi/';  % change this!

for iSub = 1:length(subjects)
        
    % current subject
    subID = subjects(iSub);
    fprintf('Now reading logfile for subject %d\n',subID)
    
    % open the logfile, read text to cell and close logfile
    fid = fopen([inPth 'SUBJECT_' num2str(subID) '_defmem.log'], 'r'); 
    c = textscan(fid, '%s', 'Delimiter', '\n');
    fclose(fid);
    
    
    %% SEARCH THE LOGFILE FOR SEARCHTERMS WITH SPECIFIED FORMAT
    
    % what terms are we looking for in the logfile
    searchterms={
    'Player location X:'
    'Player ViewRotation'
    'ENCODING TRIAL'
    'TOUCHED OBJECT'
    'SHOWING CUE'
    'DROPPED OBJECT'
    'REVEAL OBJECT'
    };

    % what do we want to get from these lines
    % this writes out the numbers in the logfile specified as %f etc
    formats={
        '[%f] ScriptLog: %f Player location X: %f Y: %f Z: %f'
        '[%f] ScriptLog: %f Player ViewRotation Yaw: %f Pitch: %f Roll: %f'
        '[%f] ScriptLog: %f ENCODING TRIAL %f, SPAWNING OBJECT %f at X: %f Y: %f'
        '[%f] ScriptLog: %f TOUCHED OBJECT at X: %f Y: %f'
        '[%f] ScriptLog: %f TRIAL %f SHOWING CUE FOR OBJECT %f, OBJECT NAME:'
        '[%f] ScriptLog: %f TRIAL %f DROPPED OBJECT at X: %f Y: %f, OBJECT NAME: %*s'
        '[%f] ScriptLog: %f TRIAL %f REVEAL OBJECT %f at X: %f Y: %f'
        };

    % initialize counters and storage variable
    searchtermCounters=zeros(size(searchterms,1),1);
    searchtermStorage={};

    % go through all lines of the log file and decide what to do with it
    for i=1:size(c{1,1},1)
        tempstr=c{1,1}(i);
        for j=1:size(searchterms,1)
            tempsearchterm=searchterms{j,1};
            k = strfind(tempstr{1}, tempsearchterm);
            if isempty(k)==0
                searchtermCounters(j)=searchtermCounters(j)+1;
                searchtermStorage{j}(searchtermCounters(j),:)=textscan(tempstr{1},formats{j},'Delimiter',' ','CollectOutput', true);
            end
        end
    end
    
    %% TRANSFORM THE VARIABLES FROM THE LOGFILE SEARCH TO NICE VARIABLE
    tmpLoc      = cell2mat(searchtermStorage{1});
    tmpRot      = cell2mat(searchtermStorage{2});
    tmpEnc      = cell2mat(searchtermStorage{3});
    tmpTouch    = cell2mat(searchtermStorage{4});
    tmpCue      = cell2mat(searchtermStorage{5});
    tmpDrop     = cell2mat(searchtermStorage{6});
    tmpReveal   = cell2mat(searchtermStorage{7});
    
    % store player location and rotation nicely 
    playerLoc.time  = tmpLoc(:,2);
    playerLoc.xloc  = tmpLoc(:,3);
    playerLoc.yloc  = tmpLoc(:,4);
    playerLoc.yaw   = tmpRot(:,3);
    playerLoc.pitch = tmpRot(:,4);
    playerLoc.roll  = tmpRot(:,5);
    
    % store the encoding trial info
    encTrial.number     = tmpEnc(:,3);
    encTrial.objID      = tmpEnc(:,4);
    encTrial.start      = tmpEnc(:,2);
    encTrial.objLocX    = tmpEnc(:,5);
    encTrial.objLocY    = tmpEnc(:,6);
    encTrial.stop       = tmpTouch(1:nObjects,2);
    
    % store the trial info
    trial.number        = tmpCue(:,3);
    trial.cueStart      = tmpCue(:,2);
    trial.cueID         = tmpCue(:,4);
    trial.dropTime      = tmpDrop(:,2);
    trial.dropLocX      = tmpDrop(:,4);
    trial.dropLocY      = tmpDrop(:,5);
    trial.objID         = tmpReveal(:,4);
    trial.objLocX       = tmpReveal(:,5);
    trial.objLocY       = tmpReveal(:,6);
    
    % get rid of unneeded temporary variables
    clearvars tmp*
        
    % save variables
    save([outPth 'sub_' num2str(subID) '_2'], 'trialInfo'); 
    
    clear trial encTrial playerLoc
end
