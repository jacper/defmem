clear all

%% SET UP
% which subjects
subjects = 1:16; 

% set up some stuff
nSubs       = length(subjects);
nPositions  = 8;
Positions = [-374 -68; -187 0; -374 68; -561 0; 374 -68; 561 0; 374 68; 187 0];
markerTypes = {'o' '*' '+' 'h' 's' 'd'  'p' 'x'};
colors      = [184 43 34; 196 118 75; 108 52 31;...
                108 31 61; 196 76 143; 0 128 128; 0 0 128;...
                0 128 0; 255 140 0; 128 128 0]/255;
            
iPosition = 1:nPositions;            

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
    datPth = '~/defmem/data/maptest/';
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

% transform positions to same space as our map
xSelect;

%%getting trapezoid, same dimensions as presentation
            
corners = [4751, 505; ...
    4751, -505; ...
    -4751, -2286; ...
    -4751, 2286];

corners(:,1)=corners(:,1)/6.34;
corners(:,2)=corners(:,2)/7.38;

fig01 = figure;
hold on
line(corners(1:2,1), corners(1:2,2), 'LineWidth', 5, 'Color', [0 0 0])
line(corners([2, 3],1), corners([2, 3],2) , 'LineWidth', 5, 'Color', [0 0 0])
line(corners(3:4,1), corners(3:4,2), 'LineWidth', 5, 'Color', [0 0 0])
line(corners([1, 4],1), corners([1, 4],2), 'LineWidth', 5, 'Color', [0 0 0])
axis equal
scatter(Positions(:,1), Positions(:,2), 250, 'r', markerTypes{1});
%circles(0,0,250, 'facecolor','none', 'LineWidth', 3);
%circles(0,0,500, 'facecolor','none', 'LineWidth', 3);
%circles(0,0,750, 'facecolor','none', 'LineWidth', 3);
%circles(0,0,1000, 'facecolor','none', 'LineWidth', 3);
%circles(0,0,1250, 'facecolor','none', 'LineWidth', 3);
%scatter(corners(:,1), corners(:,2))

%hold on

% loop over buildingsconfidenceconfidenceconfidence
%for iPosition = 1:nPositions
%    dondersRed  = [184 43 34]/255;
%
%    % plot correct building
%    h = scatter(Positions(iPosition,1), Positions(iPosition,2),350, markerTypes{iPosition});
%    set(h, 'MarkerEdgeColor', [0 0 0], 'LineWidth', 4)
%    
%    % plot given locations
%    g = scatter(xSelect(iPosition,:), ySelect(iPosition,:),250, colors(1:nSubs,:), markerTypes{iPosition});
%    set(g, 'LineWidth', 3)
%   
%end

hold on 

for iPosition=1:8;
    iSub=1:16;
    dondersRed  = [184 43 34]/255;
    
    %subplot (4,4,iSub)
    scatter(xSelect(iPosition,:), ySelect(iPosition,:), 50, dondersRed, 'filled')
    axis equal
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

% normalize the error (FNWI north entrance - Trigon)
[~,refDist] = cart2pol(835-242,242-127);
errSize = errSize / refDist;

% average error per participant
meanError = mean(errSize);

%%%%%SUBPLOTTING 16 trapezoids %%%%%%%%
dondersRed  = [184 43 34]/255;

figure
hold on
for iSub = 1:nSubs;
    
    %% SUBPLOT selected positions for each subject
    c=subplot(4,4,iSub);
    hold on
    
    line(corners(1:2,1), corners(1:2,2), 'LineWidth', 3, 'Color', [0 0 0])
    line(corners([2, 3],1), corners([2, 3],2) , 'LineWidth', 3, 'Color', [0 0 0])
    line(corners(3:4,1), corners(3:4,2), 'LineWidth', 3, 'Color', [0 0 0])
    line(corners([1, 4],1), corners([1, 4],2), 'LineWidth', 3, 'Color', [0 0 0])
    
    
    for iPosition= 1:nPositions;
        hold on 
        scatter(xSelect(iPosition,iSub), ySelect(iPosition,iSub), 50, dondersRed, markerTypes{iPosition});   %%%%not working different markerTypes neither colors
        scatter(Positions(iPosition,1), Positions(iPosition,2), 50, 'r', markerTypes{iPosition});
        %set(h, 'MarkerEdgeColor', [0 0 0], 'LineWidth', 4)
    end
    axis equal
end


