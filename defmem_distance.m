clear all
%% SET UP
% which subjects
subjects =1:16;

% set up some stuff
nSubs       = length(subjects);
nPositions  = 8;
nTrials     = 28;
coordinatesPos = [-374 -68; -187 0; -374 68; -561 0; 374 -68; 561 0; 374 68; 187 0]; %origin= middle

%initialize
p1          = nan(nTrials,nSubs);
p2          = nan(nTrials,nSubs);
trialOnset  = nan(nTrials,nSubs);
respTime    = nan(nTrials,nSubs);
givenDist   = nan(nTrials,nSubs);
p1x         = nan(nTrials,nSubs);
p1y         = nan(nTrials,nSubs);
p2x         = nan(nTrials,nSubs);
p2y         = nan(nTrials,nSubs);
corrValues  = nan(nSubs,1);
pCorr       = nan(nSubs,1);

%% GET DATA
for iSub = 1:nSubs;
    subID = subjects(iSub);
    
    % where is the data
    datPth = '~/defmem/data/distanceJudgment';
    fName = sprintf('%02d_distance_judgments.txt', subID);

    % read logfiles
    logDat = dlmread(fullfile(datPth,fName),'\t');
    
    % store variables
    p1(:,iSub)          = logDat(:,1);
    p2(:,iSub)          = logDat(:,2);
    trialOnset(:,iSub)  = logDat(:,5)/10000;
    givenDist(:,iSub)   = (logDat(:,6)-min(logDat(:,6)))/range(logDat(:,6)); % normalized from 0-1
    respTime(:,iSub)    = logDat(:,8)/1000;
end

% get average RT
meanRT = mean(respTime);

%% ANALYZE DISTANCES

% get the coords for the correct locations
for iTrial = 1:nTrials
    
    p1x(iTrial,:) = coordinatesPos(p1(iTrial,:),1);
    p1y(iTrial,:) = coordinatesPos(p1(iTrial,:),2);
    p2x(iTrial,:) = coordinatesPos(p2(iTrial,:),1);
    p2y(iTrial,:) = coordinatesPos(p2(iTrial,:),2);
end

% get correct directions in radians
[~, corrDist] = cart2pol(p2x-p1x, p2y-p1y);
corrDist    = corrDist/max(corrDist(:)); %% noramlized from 0-1 (closest and furthest possible distances)

%average error for each participant= how good they are 
average_error_subs=mean(givenDist-corrDist);


for iSub = 1:nSubs
    dondersRed  = [184 43 34]/255;

    %correlate given distance with actual distance
    [corrValues(iSub), pCorr(iSub)] = corr(givenDist(:,iSub),corrDist(:,iSub));
    
    %% PLOT SCATTER WITH LEAST SQUARES LINE
    subplot(4,4,iSub)
    scatter(givenDist(:,iSub), corrDist(:,iSub), 30, dondersRed,'filled')
    xlabel('remembered distance 0-1', 'Fontsize', 8)
    ylabel('actual distance 0-1', 'Fontsize', 8)
    axis square
    title(sprintf('\nr=%.2f, p=%.2f, mean RT=%.1fs', corrValues(iSub), pCorr(iSub), meanRT(iSub)), 'Fontsize', 8)
    h = lsline;
    set((h),'color', dondersRed, 'LineWidth',2)
end




%%INTERESTING DISTANCES TO LOOK AT
paralel_y.all=(p1==3 & p2==1 ...
            |  p1==1 & p2==3 ...
            |  p1==7 & p2==5 ...
            |  p1==5 & p2==7);                      %%%%%paralel to Y: 3-1 & 7-5
paralel_y.broad=(p1==3 & p2==1 ...
              |  p1==1 & p2==3);
paralel_y.narrow=(p1==7 & p2==5 ...
                | p1==5 & p2==7);

paralel_x0.all=(p1==4 & p2==2 ...
              | p1==2 & p2==8 ...
              | p1==8 & p2==6 ...
              | p1==2 & p2==4 ...
              | p1==8 & p2==2 ...
              | p1==6 & p2==8);
paralel_x0.narrow=(p1==8 & p2==6 ...
                 | p1==6 & p2==8);
paralel_x0.broad=(p1==4 & p2==2 ...
                | p1==2 & p2==4);
paralel_x0.middle=(p1==8 & p2==2 ...
                 | p1==2 & p2==8);
paralel_x0.longer.broad=(p1==4 & p2==8 ...
                       | p1==8 & p2==4);
paralel_x0.longer.narrow=(p1==2 & p2==6 ...
                        | p1==6 & p2==2);
paralel_x0.longest=(p1==4 & p2==6 ...
                  | p1==6 & p2==4);

%%%%%%playing with them
%%plotting

figure
hold on
scatter(corrDist(paralel_y.narrow(:,:)),givenDist(paralel_y.narrow(:,:)), 50, 'r', 'o');
scatter(corrDist(paralel_y.broad(:,:)),givenDist(paralel_y.broad(:,:)), 50, 'b', 'x');

scatter(corrDist(paralel_x0.narrow(:,:)), givenDist(paralel_x0.narrow(:,:)), 50, 'r', 'o');
scatter(corrDist(paralel_x0.broad(:,:)), givenDist(paralel_x0.broad(:,:)), 50, 'b', 'x');
scatter(corrDist(paralel_x0.middle(:,:)), givenDist(paralel_x0.middle(:,:)), 50, 'g', '*');

scatter(corrDist(paralel_x0.longer.narrow(:,:)), givenDist(paralel_x0.longer.narrow(:,:)), 50, 'r', 'o');
scatter(corrDist(paralel_x0.longer.broad(:,:)), givenDist(paralel_x0.longer.broad(:,:)), 50, 'b', 'x');

scatter(corrDist(paralel_x0.longest(:,:)), givenDist(paralel_x0.longest(:,:)), 50, 'g', '*');


%%means

mean_error_y.narrow=mean(givenDist(paralel_y.narrow));
mean_error_y.broad=mean(givenDist(paralel_y.broad));
mean_error_x.narrow=mean(givenDist(paralel_x0.narrow));
mean_error_x.broad=mean(givenDist(paralel_x0.broad));
mean_error_x.middle=mean(givenDist(paralel_x0.middle));
mean_error_x.longer_broad=mean(givenDist(paralel_x0.longer.broad));
mean_error_x.longer_narrow=mean(givenDist(paralel_x0.longer.narrow));
mean_error_x.longest=mean(givenDist(paralel_x0.longest));



%%%%%%%%PLOTTING GIVEN, CORRECT DISTANCES VS p1
figure
hold on
for iSub = 1:nSubs
    dondersRed  = [184 43 34]/255;

    %correlate given distance with actual distance
    [corrValues(iSub), pCorr(iSub)] = corr(givenDist(:,iSub),corrDist(:,iSub));
    
    %% PLOT SCATTER WITH LEAST SQUARES LINE
    subplot(4,4,iSub)
    scatter(p1(:,iSub), givenDist(:,iSub), 50, dondersRed,'filled')
    xlabel('position p1', 'Fontsize', 8)
    ylabel('remembered distance 0-1', 'Fontsize', 8)
    %axis square
%     title(sprintf('objective vs. subjective distance: \nr=%.2f, p=%.2f, mean RT=%.1fs', corrValues(iSub), pCorr(iSub), meanRT(iSub)), 'Fontsize', 12)
    h = lsline;
    set((h),'color', dondersRed, 'LineWidth',2)
%     set(gca, 'YLim',[0 1], 'XLim', [0.2 1.6],'XTick', [.4 1 1.6], 'YTick', [0 .5 1])

end
figure
hold on
for iSub = 1:nSubs
    dondersRed  = [184 43 34]/255;

    %correlate given distance with actual distance
    [corrValues(iSub), pCorr(iSub)] = corr(givenDist(:,iSub),corrDist(:,iSub));
    
    %% PLOT SCATTER WITH LEAST SQUARES LINE
    subplot(4,4,iSub)
    scatter(p1(:,iSub), corrDist(:,iSub))
    xlabel('position p1', 'Fontsize', 8)
    ylabel('correct distance 0-1', 'Fontsize', 8)
    %axis square
%     title(sprintf('objective vs. subjective distance: \nr=%.2f, p=%.2f, mean RT=%.1fs', corrValues(iSub), pCorr(iSub), meanRT(iSub)), 'Fontsize', 12)
    h = lsline;
    %set((h),'color', dondersRed, 'LineWidth',2)
%     set(gca, 'YLim',[0 1], 'XLim', [0.2 1.6],'XTick', [.4 1 1.6], 'YTick', [0 .5 1])
end

figure
hold on
%%% correct and given distances vs p1
for iSub = 1:nSubs
    dondersRed  = [184 43 34]/255;

    %correlate given distance with actual distance
    [corrValues(iSub), pCorr(iSub)] = corr(givenDist(:,iSub),corrDist(:,iSub));
    
    %% PLOT SCATTER WITH LEAST SQUARES LINE
    subplot(4,4,iSub)
    scatter(p1(:,iSub), givenDist(:,iSub), 50, dondersRed,'filled')
    xlabel('position p1', 'Fontsize', 8)
    ylabel('remembered distance 0-1', 'Fontsize', 8)
    %axis square
%     title(sprintf('objective vs. subjective distance: \nr=%.2f, p=%.2f, mean RT=%.1fs', corrValues(iSub), pCorr(iSub), meanRT(iSub)), 'Fontsize', 12)
    h = lsline;
    set((h),'color', dondersRed, 'LineWidth',2)
%     set(gca, 'YLim',[0 1], 'XLim', [0.2 1.6],'XTick', [.4 1 1.6], 'YTick', [0 .5 1])
    hold on
    subplot(4,4,iSub)
    scatter(p1(:,iSub), corrDist(:,iSub))
    xlabel('position p1', 'Fontsize', 8)
    ylabel('correct distance 0-1', 'Fontsize', 8)
    %axis square
%     title(sprintf('objective vs. subjective distance: \nr=%.2f, p=%.2f, mean RT=%.1fs', corrValues(iSub), pCorr(iSub), meanRT(iSub)), 'Fontsize', 12)
    h = lsline;
end

