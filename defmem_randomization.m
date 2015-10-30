%% RANDOMIZATION FOR DEFMEM V1 WITH 8 POSTIONS/OBJECTS
% writes INI-file for object location task with objects in random order
% with the constraints that each object is sampled n times before an object
% is sampled n+1 times and no object is sampled twice in a row

clear all

% randomize the seed to actually get random numbers
s = RandStream('mt19937ar','Seed','shuffle');
RandStream.setGlobalStream(s);

%% INITIALIAZE VARIABLES
nObjects    = 8;
nSubs       = 50;
nReps       = 31;
randomOrder = nan(nObjects, nReps);
outPth      = '/home/memspa/jacbel/_defmem/behaviour/INI-Files';
outPthPres  = '/home/memspa/jacbel/_defmem/behaviour/presentation/OrderFiles';

% define positions
% positions = [3563, 0, 90;...
%     1189, 0, 90;...
%     -3563, 0, 90;...
%     -1189, 0, 90;...
%     2376, 1188, 90;...
%     2376, -1188, 90;...
%     -2376, 1188, 90;...
%     -2376, -1188, 90;...
%     ];

positions = [...
    -2376, 500, 90;...
    -1187, 0, 90;...
    -2376, -500, 90;...
    -3563, 0, 90;...
    2376, 500, 90;...
    3563, 0, 90;...
    2376, -500, 90;...
    1187, 0, 90;...
    ];

corners = [4751, 505; ...
    4751, -505; ...
    -4751, -2286; ...
    -4751, 2286];

fig01 = figure;
hold on
line(corners(1:2,1), corners(1:2,2), 'LineWidth', 10, 'Color', [0 0 0])
line(corners([2, 3],1), corners([2, 3],2) , 'LineWidth', 10, 'Color', [0 0 0])
line(corners(3:4,1), corners(3:4,2), 'LineWidth', 10, 'Color', [0 0 0])
line(corners([1, 4],1), corners([1, 4],2), 'LineWidth', 10, 'Color', [0 0 0])
axis equal
scatter(positions(:,1), positions(:,2), 250, 'r', 'LineWidth', 5)
circles(0,0,250, 'facecolor','none', 'LineWidth', 3);
circles(0,0,500, 'facecolor','none', 'LineWidth', 3);
circles(0,0,750, 'facecolor','none', 'LineWidth', 3);
circles(0,0,1000, 'facecolor','none', 'LineWidth', 3);
circles(0,0,1250, 'facecolor','none', 'LineWidth', 3);
% scatter(corners(:,1), corners(:,2))

fig02 = figure;
hold on
line(corners(1:2,1), corners(1:2,2), 'LineWidth', 10, 'Color', [0 0 0])
line(corners([2, 3],1), corners([2, 3],2) , 'LineWidth', 10, 'Color', [0 0 0])
line(corners(3:4,1), corners(3:4,2), 'LineWidth', 10, 'Color', [0 0 0])
line(corners([1, 4],1), corners([1, 4],2), 'LineWidth', 10, 'Color', [0 0 0])
scatter(0,0,'r', 'LineWidth', 5)
axis equal
circles(0,0,500, 'facecolor','none', 'LineWidth', 3);


% names of the objects we use
objectNames = {'africanmask', 'airpump', 'bell', 'book', 'carved_pumpkin', 'drill', ...
    'globe', 'stain_glass_lamp', 'baby_bottle', 'rubber_duck', 'straw_hat', 'vase'};

for iSub = 1:nSubs

    % shuffle object names for this participant (1st nObjects will be used)
    objectNames(1:length(objectNames)) = objectNames(randperm(length(objectNames)));
    
    objects = objectNames(1:nObjects);
    
    
    %% RANDOMIZATION OBJECT LOCATION TASK
    
    % define the first repetition (encoding trials)
    randomOrder(:,1) = randperm(8);

    for iRep = 2:nReps;

        % bool to get out of the while loop
        noRep = 0;

        while noRep == false;

            % randomize the order of this repetition
            randomOrder(:,iRep) = randperm(8);


            % check if first item of current repetition isn't the same as the
            % last item of the previous repetition
            if randomOrder(1,iRep) ~= randomOrder(nObjects,iRep-1)

                noRep = true;
            end
        end
    end


    %% SAVE INI FILE FOR OBJECT LOCATION TASK

    % open INI file
    outfile = fopen(fullfile(outPth, sprintf('Default_defmemGame_%02d.ini', iSub)), 'w');
    
    % print header
    fprintf(outfile, '[defmem_Game.defmemGame_Master]\n\n');

    % print the encoding object IDs
    for iEncTrial = 1:nObjects;
        fprintf(outfile, 'EncodingObjectID[%d]=%d\n',...
            iEncTrial, randomOrder(iEncTrial,1));
    end
    
    % print the encoding object locations
    for iEncTrial = 1:nObjects;
        fprintf(outfile, 'EncodingObjectLoc[%d]=(X=%d,Y=%d,Z=%d)\n',...
            iEncTrial, positions(randomOrder(iEncTrial,1),1), positions(randomOrder(iEncTrial,1),2), positions(randomOrder(iEncTrial,3),3));
    end
    
    % print encoding object names
    for iEncTrial = 1:nObjects;
        fprintf(outfile, 'EncodingObjectName[%d]=%s\n',...
            iEncTrial, objects{randomOrder(iEncTrial,1)});
    end
    
    % print the object IDs for main trials
    for iTrial = nObjects+1:nObjects*nReps;
        fprintf(outfile, 'ObjectID[%d]=%d\n',...
            iTrial-nObjects, randomOrder(iTrial));
    end
    
    % print the object locations for main trials
    for iTrial = nObjects+1:nObjects*nReps;
        fprintf(outfile, 'ObjectLoc[%d]=(X=%d,Y=%d,Z=%d)\n',...
            iTrial-nObjects, positions(randomOrder(iTrial),1), positions(randomOrder(iTrial),2), positions(randomOrder(iTrial),3));
    end
    
    % print object names for main trials
    for iTrial = nObjects+1:nObjects*nReps;
        fprintf(outfile, 'ObjectName[%d]=%s\n',...
            iTrial-nObjects, objects{randomOrder(iTrial)});
    end
        
    % close the file
    fclose(outfile);
    
    
    %% RANDOMIZATION DISTANCE JUDGEMENT

    % trial combinations (all combinations of objects
    combs = combnk(1:nObjects,2);
    for iPair = 1:length(combs(:,1))
        combs(iPair,:) = combs(iPair,randperm(2)); % shuffle pairs
    end
    
    % trial order
    nTrials = length(combs(:,1));
    trialOrder = [1:nTrials]';
    trialOrder = trialOrder(randperm(nTrials));
     
    % write files for objects 1 and 2 and trial order
    fid = fopen(fullfile(outPthPres,sprintf('%02d_object1_distanceJudge.txt',iSub)), 'w');
    fprintf(fid, '%d\n',combs(:,1));
    fclose(fid);

    fid = fopen(fullfile(outPthPres,sprintf('%02d_object2_distanceJudge.txt',iSub)), 'w');
    fprintf(fid, '%d\n',combs(:,2));
    fclose(fid);

    fid = fopen(fullfile(outPthPres,sprintf('%02d_trialOrder_distanceJudge.txt',iSub)), 'w');
    fprintf(fid, '%d\n',trialOrder);
    fclose(fid);
    
    % write out the objects to use for this subject
    fid = fopen(fullfile(outPthPres,sprintf('%02d_objects.txt',iSub)), 'w');
    fprintf(fid, '%s.tga\n',objects{1:nObjects});
    fclose(fid);
    clear combs
end % subject

