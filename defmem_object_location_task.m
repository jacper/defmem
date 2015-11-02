clear all
datPth = '~/defmem/data';
%%concatenating read logs

nSubs = 16;


%% initialize variables
nTrials = nan(nSubs,1);

for iSub = 1:nSubs
    
    tmp = load(fullfile(datPth, sprintf('UDK_logssub_%d_2.mat',iSub)));
    player(iSub)    = tmp.player;
    trial(iSub)     = tmp.trial;
    enctrial(iSub)  = tmp.encTrial;
end

% get number of valid trials
for iSub = 1:nSubs
    
    if length(trial(iSub).cueID) <= 239
        
        nTrials(iSub) = length(trial(iSub).cueID);
        
    else
        nTrials(iSub) = 239;
    end
end

%%%%LOADING MULTIPLE FILES AT ONCE
%sub(iSub)=load('M:\defmem\data\UDK_logssub_%02d_2.mat', 'trial', iSub);
%subs= load('UDK_logssub_\d_2.mat', 'trial', iSub);
%%%%%%%%%%%

%%creating means of all subjects per location

%sub_1.trial.cueID=sub_1.trial.cueID(1:217);
%sub_2.trial.cueID=sub_2.trial.cueID(1:239);
%sub_3.trial.cueID=sub_3.trial.cueID(1:225);
%sub_4.trial.cueID=sub_4.trial.cueID(1:239);
%sub_5.trial.cueID=sub_5.trial.cueID(1:239);
%sub_6.trial.cueID=sub_6.trial.cueID(1:239);
%sub_7.trial.cueID=sub_7.trial.cueID(1:239);
%sub_8.trial.cueID=sub_8.trial.cueID(1:167);
%sub_9.trial.cueID=sub_9.trial.cueID(1:239);
%sub_10.trial.cueID=sub_10.trial.cueID(1:239);
%sub_11.trial.cueID=sub_11.trial.cueID(1:239);
%sub_12.trial.cueID=sub_12.trial.cueID(1:239);
%sub_13.trial.cueID=sub_13.trial.cueID(1:239);
%sub_14.trial.cueID=sub_14.trial.cueID(1:239);
%sub_15.trial.cueID=sub_15.trial.cueID(1:239);
%sub_16.trial.cueID=sub_16.trial.cueID(1:239);

mean_drop_locX= [mean(sub_1.trial.dropLocX(sub_1.trial.cueID==1)),mean(sub_1.trial.dropLocX(sub_1.trial.cueID==2)),mean(sub_1.trial.dropLocX(sub_1.trial.cueID==3)),mean(sub_1.trial.dropLocX(sub_1.trial.cueID==4)),mean(sub_1.trial.dropLocX(sub_1.trial.cueID==5)),mean(sub_1.trial.dropLocX(sub_1.trial.cueID==6)),mean(sub_1.trial.dropLocX(sub_1.trial.cueID==7)),mean(sub_1.trial.dropLocX(sub_1.trial.cueID==8));mean(sub_2.trial.dropLocX(sub_2.trial.cueID==1)),mean(sub_2.trial.dropLocX(sub_2.trial.cueID==2)),mean(sub_2.trial.dropLocX(sub_2.trial.cueID==3)),mean(sub_2.trial.dropLocX(sub_2.trial.cueID==4)),mean(sub_2.trial.dropLocX(sub_2.trial.cueID==5)),mean(sub_2.trial.dropLocX(sub_2.trial.cueID==6)),mean(sub_2.trial.dropLocX(sub_2.trial.cueID==7)),mean(sub_2.trial.dropLocX(sub_2.trial.cueID==8));mean(sub_3.trial.dropLocX(sub_3.trial.cueID==1)),mean(sub_3.trial.dropLocX(sub_3.trial.cueID==2)),mean(sub_3.trial.dropLocX(sub_3.trial.cueID==3)),mean(sub_3.trial.dropLocX(sub_3.trial.cueID==4)),mean(sub_3.trial.dropLocX(sub_3.trial.cueID==5)),mean(sub_3.trial.dropLocX(sub_3.trial.cueID==6)),mean(sub_3.trial.dropLocX(sub_3.trial.cueID==7)),mean(sub_3.trial.dropLocX(sub_3.trial.cueID==8));mean(sub_4.trial.dropLocX(sub_4.trial.cueID==1)),mean(sub_4.trial.dropLocX(sub_4.trial.cueID==2)),mean(sub_4.trial.dropLocX(sub_4.trial.cueID==3)),mean(sub_4.trial.dropLocX(sub_4.trial.cueID==4)),mean(sub_4.trial.dropLocX(sub_4.trial.cueID==5)),mean(sub_4.trial.dropLocX(sub_4.trial.cueID==6)),mean(sub_4.trial.dropLocX(sub_4.trial.cueID==7)),mean(sub_4.trial.dropLocX(sub_4.trial.cueID==8));mean(sub_5.trial.dropLocX(sub_5.trial.cueID==1)),mean(sub_5.trial.dropLocX(sub_5.trial.cueID==2)),mean(sub_5.trial.dropLocX(sub_5.trial.cueID==3)),mean(sub_5.trial.dropLocX(sub_5.trial.cueID==4)),mean(sub_5.trial.dropLocX(sub_5.trial.cueID==5)),mean(sub_5.trial.dropLocX(sub_5.trial.cueID==6)),mean(sub_5.trial.dropLocX(sub_5.trial.cueID==7)),mean(sub_5.trial.dropLocX(sub_5.trial.cueID==8));mean(sub_6.trial.dropLocX(sub_6.trial.cueID==1)),mean(sub_6.trial.dropLocX(sub_6.trial.cueID==2)),mean(sub_6.trial.dropLocX(sub_6.trial.cueID==3)),mean(sub_6.trial.dropLocX(sub_6.trial.cueID==4)),mean(sub_6.trial.dropLocX(sub_6.trial.cueID==5)),mean(sub_6.trial.dropLocX(sub_6.trial.cueID==6)),mean(sub_6.trial.dropLocX(sub_6.trial.cueID==7)),mean(sub_6.trial.dropLocX(sub_6.trial.cueID==8));mean(sub_7.trial.dropLocX(sub_7.trial.cueID==1)),mean(sub_7.trial.dropLocX(sub_7.trial.cueID==2)),mean(sub_7.trial.dropLocX(sub_7.trial.cueID==3)),mean(sub_7.trial.dropLocX(sub_7.trial.cueID==4)),mean(sub_7.trial.dropLocX(sub_7.trial.cueID==5)),mean(sub_7.trial.dropLocX(sub_7.trial.cueID==6)),mean(sub_7.trial.dropLocX(sub_7.trial.cueID==7)),mean(sub_7.trial.dropLocX(sub_7.trial.cueID==8));mean(sub_8.trial.dropLocX(sub_8.trial.cueID==1)),mean(sub_8.trial.dropLocX(sub_8.trial.cueID==2)),mean(sub_8.trial.dropLocX(sub_8.trial.cueID==3)),mean(sub_8.trial.dropLocX(sub_8.trial.cueID==4)),mean(sub_8.trial.dropLocX(sub_8.trial.cueID==5)),mean(sub_8.trial.dropLocX(sub_8.trial.cueID==6)),mean(sub_8.trial.dropLocX(sub_8.trial.cueID==7)),mean(sub_8.trial.dropLocX(sub_8.trial.cueID==8));mean(sub_9.trial.dropLocX(sub_9.trial.cueID==1)),mean(sub_9.trial.dropLocX(sub_9.trial.cueID==2)),mean(sub_9.trial.dropLocX(sub_9.trial.cueID==3)),mean(sub_9.trial.dropLocX(sub_9.trial.cueID==4)),mean(sub_9.trial.dropLocX(sub_9.trial.cueID==5)),mean(sub_9.trial.dropLocX(sub_9.trial.cueID==6)),mean(sub_9.trial.dropLocX(sub_9.trial.cueID==7)),mean(sub_9.trial.dropLocX(sub_9.trial.cueID==8));mean(sub_10.trial.dropLocX(sub_10.trial.cueID==1)),mean(sub_10.trial.dropLocX(sub_10.trial.cueID==2)),mean(sub_10.trial.dropLocX(sub_10.trial.cueID==3)),mean(sub_10.trial.dropLocX(sub_10.trial.cueID==4)),mean(sub_10.trial.dropLocX(sub_10.trial.cueID==5)),mean(sub_10.trial.dropLocX(sub_10.trial.cueID==6)),mean(sub_10.trial.dropLocX(sub_10.trial.cueID==7)),mean(sub_10.trial.dropLocX(sub_10.trial.cueID==8));mean(sub_11.trial.dropLocX(sub_11.trial.cueID==1)),mean(sub_11.trial.dropLocX(sub_11.trial.cueID==2)),mean(sub_11.trial.dropLocX(sub_11.trial.cueID==3)),mean(sub_11.trial.dropLocX(sub_11.trial.cueID==4)),mean(sub_11.trial.dropLocX(sub_11.trial.cueID==5)),mean(sub_11.trial.dropLocX(sub_11.trial.cueID==6)),mean(sub_11.trial.dropLocX(sub_11.trial.cueID==7)),mean(sub_11.trial.dropLocX(sub_11.trial.cueID==8));mean(sub_12.trial.dropLocX(sub_12.trial.cueID==1)),mean(sub_12.trial.dropLocX(sub_12.trial.cueID==2)),mean(sub_12.trial.dropLocX(sub_12.trial.cueID==3)),mean(sub_12.trial.dropLocX(sub_12.trial.cueID==4)),mean(sub_12.trial.dropLocX(sub_12.trial.cueID==5)),mean(sub_12.trial.dropLocX(sub_12.trial.cueID==6)),mean(sub_12.trial.dropLocX(sub_12.trial.cueID==7)),mean(sub_12.trial.dropLocX(sub_12.trial.cueID==8));mean(sub_13.trial.dropLocX(sub_13.trial.cueID==1)),mean(sub_13.trial.dropLocX(sub_13.trial.cueID==2)),mean(sub_13.trial.dropLocX(sub_13.trial.cueID==3)),mean(sub_13.trial.dropLocX(sub_13.trial.cueID==4)),mean(sub_13.trial.dropLocX(sub_13.trial.cueID==5)),mean(sub_13.trial.dropLocX(sub_13.trial.cueID==6)),mean(sub_13.trial.dropLocX(sub_13.trial.cueID==7)),mean(sub_13.trial.dropLocX(sub_13.trial.cueID==8));mean(sub_14.trial.dropLocX(sub_14.trial.cueID==1)),mean(sub_14.trial.dropLocX(sub_14.trial.cueID==2)),mean(sub_14.trial.dropLocX(sub_14.trial.cueID==3)),mean(sub_14.trial.dropLocX(sub_14.trial.cueID==4)),mean(sub_14.trial.dropLocX(sub_14.trial.cueID==5)),mean(sub_14.trial.dropLocX(sub_14.trial.cueID==6)),mean(sub_14.trial.dropLocX(sub_14.trial.cueID==7)),mean(sub_14.trial.dropLocX(sub_14.trial.cueID==8));mean(sub_15.trial.dropLocX(sub_15.trial.cueID==1)),mean(sub_15.trial.dropLocX(sub_15.trial.cueID==2)),mean(sub_15.trial.dropLocX(sub_15.trial.cueID==3)),mean(sub_15.trial.dropLocX(sub_15.trial.cueID==4)),mean(sub_15.trial.dropLocX(sub_15.trial.cueID==5)),mean(sub_15.trial.dropLocX(sub_15.trial.cueID==6)),mean(sub_15.trial.dropLocX(sub_15.trial.cueID==7)),mean(sub_15.trial.dropLocX(sub_15.trial.cueID==8));mean(sub_16.trial.dropLocX(sub_16.trial.cueID==1)),mean(sub_16.trial.dropLocX(sub_16.trial.cueID==2)),mean(sub_16.trial.dropLocX(sub_16.trial.cueID==3)),mean(sub_16.trial.dropLocX(sub_16.trial.cueID==4)),mean(sub_16.trial.dropLocX(sub_16.trial.cueID==5)),mean(sub_16.trial.dropLocX(sub_16.trial.cueID==6)),mean(sub_16.trial.dropLocX(sub_16.trial.cueID==7)),mean(sub_16.trial.dropLocX(sub_16.trial.cueID==8))];
%%% do it easier
%meanlocx= mean(sprintf('sub_%d.trial.dropLocX'(sprintf('sub_%d.trial.cueID'==1,iSub)), iSub);

mean_drop_locY= [mean(sub_1.trial.dropLocY(sub_1.trial.cueID==1)),mean(sub_1.trial.dropLocY(sub_1.trial.cueID==2)),mean(sub_1.trial.dropLocY(sub_1.trial.cueID==3)),mean(sub_1.trial.dropLocY(sub_1.trial.cueID==4)),mean(sub_1.trial.dropLocY(sub_1.trial.cueID==5)),mean(sub_1.trial.dropLocY(sub_1.trial.cueID==6)),mean(sub_1.trial.dropLocY(sub_1.trial.cueID==7)),mean(sub_1.trial.dropLocY(sub_1.trial.cueID==8));mean(sub_2.trial.dropLocY(sub_2.trial.cueID==1)),mean(sub_2.trial.dropLocY(sub_2.trial.cueID==2)),mean(sub_2.trial.dropLocY(sub_2.trial.cueID==3)),mean(sub_2.trial.dropLocY(sub_2.trial.cueID==4)),mean(sub_2.trial.dropLocY(sub_2.trial.cueID==5)),mean(sub_2.trial.dropLocY(sub_2.trial.cueID==6)),mean(sub_2.trial.dropLocY(sub_2.trial.cueID==7)),mean(sub_2.trial.dropLocY(sub_2.trial.cueID==8));mean(sub_3.trial.dropLocY(sub_3.trial.cueID==1)),mean(sub_3.trial.dropLocY(sub_3.trial.cueID==2)),mean(sub_3.trial.dropLocY(sub_3.trial.cueID==3)),mean(sub_3.trial.dropLocY(sub_3.trial.cueID==4)),mean(sub_3.trial.dropLocY(sub_3.trial.cueID==5)),mean(sub_3.trial.dropLocY(sub_3.trial.cueID==6)),mean(sub_3.trial.dropLocY(sub_3.trial.cueID==7)),mean(sub_3.trial.dropLocY(sub_3.trial.cueID==8));mean(sub_4.trial.dropLocY(sub_4.trial.cueID==1)),mean(sub_4.trial.dropLocY(sub_4.trial.cueID==2)),mean(sub_4.trial.dropLocY(sub_4.trial.cueID==3)),mean(sub_4.trial.dropLocY(sub_4.trial.cueID==4)),mean(sub_4.trial.dropLocY(sub_4.trial.cueID==5)),mean(sub_4.trial.dropLocY(sub_4.trial.cueID==6)),mean(sub_4.trial.dropLocY(sub_4.trial.cueID==7)),mean(sub_4.trial.dropLocY(sub_4.trial.cueID==8));mean(sub_5.trial.dropLocY(sub_5.trial.cueID==1)),mean(sub_5.trial.dropLocY(sub_5.trial.cueID==2)),mean(sub_5.trial.dropLocY(sub_5.trial.cueID==3)),mean(sub_5.trial.dropLocY(sub_5.trial.cueID==4)),mean(sub_5.trial.dropLocY(sub_5.trial.cueID==5)),mean(sub_5.trial.dropLocY(sub_5.trial.cueID==6)),mean(sub_5.trial.dropLocY(sub_5.trial.cueID==7)),mean(sub_5.trial.dropLocY(sub_5.trial.cueID==8));mean(sub_6.trial.dropLocY(sub_6.trial.cueID==1)),mean(sub_6.trial.dropLocY(sub_6.trial.cueID==2)),mean(sub_6.trial.dropLocY(sub_6.trial.cueID==3)),mean(sub_6.trial.dropLocY(sub_6.trial.cueID==4)),mean(sub_6.trial.dropLocY(sub_6.trial.cueID==5)),mean(sub_6.trial.dropLocY(sub_6.trial.cueID==6)),mean(sub_6.trial.dropLocY(sub_6.trial.cueID==7)),mean(sub_6.trial.dropLocX(sub_6.trial.cueID==8));mean(sub_7.trial.dropLocX(sub_7.trial.cueID==1)),mean(sub_7.trial.dropLocY(sub_7.trial.cueID==2)),mean(sub_7.trial.dropLocY(sub_7.trial.cueID==3)),mean(sub_7.trial.dropLocY(sub_7.trial.cueID==4)),mean(sub_7.trial.dropLocY(sub_7.trial.cueID==5)),mean(sub_7.trial.dropLocY(sub_7.trial.cueID==6)),mean(sub_7.trial.dropLocY(sub_7.trial.cueID==7)),mean(sub_7.trial.dropLocY(sub_7.trial.cueID==8));mean(sub_8.trial.dropLocY(sub_8.trial.cueID==1)),mean(sub_8.trial.dropLocY(sub_8.trial.cueID==2)),mean(sub_8.trial.dropLocY(sub_8.trial.cueID==3)),mean(sub_8.trial.dropLocY(sub_8.trial.cueID==4)),mean(sub_8.trial.dropLocY(sub_8.trial.cueID==5)),mean(sub_8.trial.dropLocY(sub_8.trial.cueID==6)),mean(sub_8.trial.dropLocY(sub_8.trial.cueID==7)),mean(sub_8.trial.dropLocY(sub_8.trial.cueID==8));mean(sub_9.trial.dropLocY(sub_9.trial.cueID==1)),mean(sub_9.trial.dropLocY(sub_9.trial.cueID==2)),mean(sub_9.trial.dropLocY(sub_9.trial.cueID==3)),mean(sub_9.trial.dropLocY(sub_9.trial.cueID==4)),mean(sub_9.trial.dropLocY(sub_9.trial.cueID==5)),mean(sub_9.trial.dropLocX(sub_9.trial.cueID==6)),mean(sub_9.trial.dropLocX(sub_9.trial.cueID==7)),mean(sub_9.trial.dropLocY(sub_9.trial.cueID==8));mean(sub_10.trial.dropLocY(sub_10.trial.cueID==1)),mean(sub_10.trial.dropLocY(sub_10.trial.cueID==2)),mean(sub_10.trial.dropLocY(sub_10.trial.cueID==3)),mean(sub_10.trial.dropLocY(sub_10.trial.cueID==4)),mean(sub_10.trial.dropLocY(sub_10.trial.cueID==5)),mean(sub_10.trial.dropLocY(sub_10.trial.cueID==6)),mean(sub_10.trial.dropLocY(sub_10.trial.cueID==7)),mean(sub_10.trial.dropLocY(sub_10.trial.cueID==8));mean(sub_11.trial.dropLocY(sub_11.trial.cueID==1)),mean(sub_11.trial.dropLocY(sub_11.trial.cueID==2)),mean(sub_11.trial.dropLocY(sub_11.trial.cueID==3)),mean(sub_11.trial.dropLocY(sub_11.trial.cueID==4)),mean(sub_11.trial.dropLocY(sub_11.trial.cueID==5)),mean(sub_11.trial.dropLocY(sub_11.trial.cueID==6)),mean(sub_11.trial.dropLocY(sub_11.trial.cueID==7)),mean(sub_11.trial.dropLocY(sub_11.trial.cueID==8));mean(sub_12.trial.dropLocY(sub_12.trial.cueID==1)),mean(sub_12.trial.dropLocY(sub_12.trial.cueID==2)),mean(sub_12.trial.dropLocY(sub_12.trial.cueID==3)),mean(sub_12.trial.dropLocY(sub_12.trial.cueID==4)),mean(sub_12.trial.dropLocY(sub_12.trial.cueID==5)),mean(sub_12.trial.dropLocY(sub_12.trial.cueID==6)),mean(sub_12.trial.dropLocY(sub_12.trial.cueID==7)),mean(sub_12.trial.dropLocY(sub_12.trial.cueID==8));mean(sub_13.trial.dropLocY(sub_13.trial.cueID==1)),mean(sub_13.trial.dropLocY(sub_13.trial.cueID==2)),mean(sub_13.trial.dropLocY(sub_13.trial.cueID==3)),mean(sub_13.trial.dropLocY(sub_13.trial.cueID==4)),mean(sub_13.trial.dropLocY(sub_13.trial.cueID==5)),mean(sub_13.trial.dropLocY(sub_13.trial.cueID==6)),mean(sub_13.trial.dropLocY(sub_13.trial.cueID==7)),mean(sub_13.trial.dropLocY(sub_13.trial.cueID==8));mean(sub_14.trial.dropLocY(sub_14.trial.cueID==1)),mean(sub_14.trial.dropLocY(sub_14.trial.cueID==2)),mean(sub_14.trial.dropLocY(sub_14.trial.cueID==3)),mean(sub_14.trial.dropLocY(sub_14.trial.cueID==4)),mean(sub_14.trial.dropLocY(sub_14.trial.cueID==5)),mean(sub_14.trial.dropLocY(sub_14.trial.cueID==6)),mean(sub_14.trial.dropLocY(sub_14.trial.cueID==7)),mean(sub_14.trial.dropLocY(sub_14.trial.cueID==8));mean(sub_15.trial.dropLocY(sub_15.trial.cueID==1)),mean(sub_15.trial.dropLocY(sub_15.trial.cueID==2)),mean(sub_15.trial.dropLocY(sub_15.trial.cueID==3)),mean(sub_15.trial.dropLocY(sub_15.trial.cueID==4)),mean(sub_15.trial.dropLocY(sub_15.trial.cueID==5)),mean(sub_15.trial.dropLocY(sub_15.trial.cueID==6)),mean(sub_15.trial.dropLocY(sub_15.trial.cueID==7)),mean(sub_15.trial.dropLocY(sub_15.trial.cueID==8));mean(sub_16.trial.dropLocY(sub_16.trial.cueID==1)),mean(sub_16.trial.dropLocY(sub_16.trial.cueID==2)),mean(sub_16.trial.dropLocY(sub_16.trial.cueID==3)),mean(sub_16.trial.dropLocY(sub_16.trial.cueID==4)),mean(sub_16.trial.dropLocY(sub_16.trial.cueID==5)),mean(sub_16.trial.dropLocY(sub_16.trial.cueID==6)),mean(sub_16.trial.dropLocY(sub_16.trial.cueID==7)),mean(sub_16.trial.dropLocY(sub_16.trial.cueID==8))];

mean_all_subs_xy=[mean(mean_drop_locX)',mean(mean_drop_locY)'];    



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


