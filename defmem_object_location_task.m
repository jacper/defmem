clear all
datPth = '~/defmem/data';


%% initialize variables
nSubs = 16;
nTrials = nan(nSubs,1);
nPos = 8;
locationError = nan(nPos,nSubs);

%load UDK files of all subjects

for iSub = 1:nSubs
    
    tmp = load(fullfile(datPth, sprintf('UDK_logssub_%d_2.mat',iSub)));
    player(iSub)    = tmp.player;
    trial(iSub)     = tmp.trial;
    enctrial(iSub)  = tmp.encTrial;
end

% get number of valid trials
for iSub = 1:nSubs
    
    if length(trial(iSub).dropLocX) <= 239
        
        nTrials(iSub) = length(trial(iSub).dropLocX);
        
    else
        nTrials(iSub) = 239;
    end
end

%get drop error in radians per participant per trial

for iSub=1:nSubs;
    
    [~, trial(:,iSub).droperror] = cart2pol(trial(:,iSub).dropLocX, trial(:,iSub).dropLocY);

end

%get average drop error per participant = how good they were

for iSub=1:nSubs;
    
    mean_droperror(iSub)= mean(trial(:,iSub).droperror(1:nTrials(iSub)));
end

figure
hold on
plot(iSub,mean_droperror, 'bd');


%get average drop error per participant per location= how tricky locations
%were
for iSub=1:nSubs;
    for iPos=1:nPos;
        
        locationError(iPos,iSub)= mean(trial(:,iSub).droperror(trial(:,iSub).cueID(trial(:,iSub).cueID==iPos)));
    end
end


%%% plotting

plot(mean_all_subs_xy(:,1), 'bo') %%% mean drop error for X
hold on
plot(mean_all_subs_xy(:,2), 'rx') %%% mean drop error for Y
hold on
xlabel ('position')
ylabel ('mean error')
h = lsline



%%%%%%TRYING TO PLOT REGRESSION USING DISTANCE IN RADIANS %%%%%%

%%%trasform distances to radians
[~, dropDist] = cart2pol(sub_1.trial.dropLocX-sub_1.trial.objLocX, sub_1.trial.dropLocY-sub_1.trial.objLocY); %%%%SUB 01 ONLY

% normalize the correct distance
[~,refDist] = cart2pol(835-242,242-127);
dropDist    = dropDist/refDist;


for i=1:8;
    mean_sub_1=[mean(dropDist(sub_1.trial.cueID==i))];   %%%%%%create a matrix 1x8
end
    

dropDist= [dropDist, cart2pol(sub_2.trial.dropLocX(1:217)-sub_2.trial.objLocX(1:217), sub_2.trial.dropLocY(1:217)-sub_2.trial.objLocY(1:217))];





for iSub = 1
    dondersRed  = [184 43 34]/255;

    %correlate given distance with actual distance
    [corrValues(iSub), pCorr(iSub)] = corr(sub_2.trial.dropLocX(1:217,:),dropDist(:,iSub)); %%% sub 2
    
    %% PLOT SCATTER WITH LEAST SQUARES LINE
    %subplot(1,2,iSub)
    %%drop distance error in radians, per location
    scatter(dropDist(:,2), sub_2.trial.cueID(1:217,:), 50, dondersRed, 'filled'); %%% sub2
    h=lsline;
    %%%
    hold off
    figure02=figure(2)
    scatter(dropDist(:,iSub), sub_1.trial.cueID, 50, dondersRed,'filled')
    xlabel('drop distance', 'Fontsize', 14)
    ylabel('location', 'Fontsize', 14)
    %axis square
    %title(sprintf('objective vs. subjective distance: \nr=%.2f, p=%.2f, mean RT=%.1fs', corrValues(iSub), pCorr(iSub), meanRT(iSub)), 'Fontsize', 12)
    h = lsline;
    set((h),'color', dondersRed, 'LineWidth',2)
    %set(gca, 'YLim',[0 1], 'XLim', [0.2 1.6],'XTick', [.4 1 1.6], 'YTick', [0 .5 1])
end


