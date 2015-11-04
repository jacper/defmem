clear all

%% SET UP
% which subjects
subjects = 1:16; 

% set up some stuff
nSubs       = length(subjects);
nPositions  = 8;
Positions = [-374 -68; -187 0; -374 68; -561 0; 374 -68; 561 0; 374 68; 187 0];
markerTypes = {'o' '*' '+' 'h' 's' 'd'  'p' 'x'};
colors      = [184 43 34;...
               255 186 0;...
               0 177 177;...
               96 136 135;...
%                123 83 104;...
               108 52 31;...
               108 31 61;...
               196 76 143;...
               0 128 128;...
               0 0 128;...
               0 128 0;...
               255 140 0;...
               128 128 0]...
               /255;

% initialize variables
trialStart  = nan(nPositions,nSubs);
mapOnset    = nan(nPositions,nSubs);
position    = nan(nPositions,nSubs);
xSelect     = nan(nPositions,nSubs);
ySelect     = nan(nPositions,nSubs);
respTime    = nan(nPositions,nSubs);
confidence  = nan(nPositions,nSubs);
xDiff       = nan(nPositions,nSubs);
yDiff       = nan(nPositions,nSubs);
errSize     = nan(nPositions,nSubs);


%% GET DATA
for iSub = 1:nSubs;
    subID = subjects(iSub);
    
    % where is the data
    datPth = '/home/memspa/jacper/defmem/data/maptest/';
    fName = sprintf('%02d_map_log.txt', subID);

    % read logfiles
    logDat = dlmread(fullfile(datPth,fName),'\t', 2, 1);
    
    % get the targets
    position(:,iSub)   = logDat (:,3);
    % sort according to position
    [position(:,iSub), sortIdx ]= sort(position(:,iSub));
    
    % store variables
    trialStart(:,iSub) = logDat (sortIdx,1);
    mapOnset(:,iSub)   = logDat (sortIdx,2);   
    xSelect(:,iSub)    = logDat (sortIdx,4);
    ySelect(:,iSub)    = logDat (sortIdx,5);
    respTime(:,iSub)   = logDat (sortIdx,6)/10000;
    confidence(:,iSub) = logDat (sortIdx,7);

end


%% getting trapezoid, same dimensions as presentation           
corners = [4751, 505; ...
    4751, -505; ...
    -4751, -2286; ...
    -4751, 2286];

corners(:,1)=corners(:,1)/6.34;
corners(:,2)=corners(:,2)/7.38;

%% plot trapezoid and given locations across particpants (color = location)
fig01 = figure;
hold on
axis equal
axis off
line(corners(1:2,1), corners(1:2,2), 'LineWidth', 5, 'Color', [0 0 0])
line(corners([2, 3],1), corners([2, 3],2) , 'LineWidth', 5, 'Color', [0 0 0])
line(corners(3:4,1), corners(3:4,2), 'LineWidth', 5, 'Color', [0 0 0])
line(corners([1, 4],1), corners([1, 4],2), 'LineWidth', 5, 'Color', [0 0 0])

for iPosition=1:8;
    
    % plot correct location as open circle
    scatter(Positions(iPosition,1), Positions(iPosition,2), 300, colors(iPosition,:), markerTypes{1}, 'LineWidth', 4);
    
    % plot response locations of all participants as filled circles
    scatter(xSelect(iPosition,:), ySelect(iPosition,:), 50,  colors(iPosition,:), 'filled')

end


%% SUBPLOT selected positions for each subject
fig02 = figure;
hold on

for iSub = 1:nSubs;
    
    % open subplot
    c=subplot(4,4,iSub);
    hold on
    
    % plot trapezoid
    line(corners(1:2,1), corners(1:2,2), 'LineWidth', 3, 'Color', [0 0 0])
    line(corners([2, 3],1), corners([2, 3],2) , 'LineWidth', 3, 'Color', [0 0 0])
    line(corners(3:4,1), corners(3:4,2), 'LineWidth', 3, 'Color', [0 0 0])
    line(corners([1, 4],1), corners([1, 4],2), 'LineWidth', 3, 'Color', [0 0 0])
    
    for iPosition= 1:nPositions;
        
        % plot the response location for this position 
        scatter(xSelect(iPosition,iSub), ySelect(iPosition,iSub), 50, colors(iPosition,:), 'filled');   
        
        % plot correct location as open circle
        scatter(Positions(iPosition,1), Positions(iPosition,2), 50, colors(iPosition,:), markerTypes{1}, 'LineWidth', 4);

    end
    axis equal
    axis off
end


%% CALCULATE SOME DESCRIPTIVE STATS

% get the average RTs
meanRT = mean(respTime);

for iSub = 1:nSubs
    
    % difference between target and selected location
    xDiff(:,iSub) = abs(xSelect(:,iSub) - Positions(:,1));
    yDiff(:,iSub) = abs(ySelect(:,iSub) - Positions(:,2));
    
    % calculate length of error vector
    [~,errSize(:,iSub)] = cart2pol(xDiff(:,iSub),yDiff(:,iSub));
end

% average error per participant
meanErrorSub = mean(errSize);
meanErrorPos = mean(errSize,2);


%% PLOT TRAPEZOID WITH AVERAGE ERROR PER LOCATION
fig03 = figure;
hold on
axis equal
axis off

% plot trapezoid
line(corners(1:2,1), corners(1:2,2), 'LineWidth', 3, 'Color', [0 0 0])
line(corners([2, 3],1), corners([2, 3],2) , 'LineWidth', 3, 'Color', [0 0 0])
line(corners(3:4,1), corners(3:4,2), 'LineWidth', 3, 'Color', [0 0 0])
line(corners([1, 4],1), corners([1, 4],2), 'LineWidth', 3, 'Color', [0 0 0])

for iPosition = 1:nPositions
    
    % plot circle at correct location with size corresponding to error
    circles(Positions(iPosition,1), Positions(iPosition,2), meanErrorPos(iPosition)/2,...
        'edgecolor', colors(iPosition,:), 'facecolor','none', 'LineWidth', 5);
    
end