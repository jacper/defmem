clear all
datPth = '~/defmem/data';


%% initialize variables
nSubs = 16;
nTrials = nan(nSubs,1);
nPos = 8;
locationError = nan(nPos,nSubs);
markerTypes = {'o' '*' '+' 'h' 's' 'd'  'p' 'x'};
dondersRed  = [184 43 34]/255;


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


%%%trasform distances to radians per participant per trial
%%%%%%%% dropDist=dropLoc, NOT distance, just location (???)

for iSub=1:nSubs;
    [~, tmp]= cart2pol(trial(:,iSub).dropLocX, trial(:,iSub).dropLocY); 
    trial(:,iSub).dropDist = tmp(1:nTrials(iSub));
end

%%% get drop error per dimension per trial per participant
%%%%%% there are negative values
for iSub=1:nSubs;
    
     trial(:,iSub).droperrorX = trial(:,iSub).objLocX-trial(:,iSub).dropLocX;
     trial(:,iSub).droperrorY = trial(:,iSub).objLocY-trial(:,iSub).dropLocY;

end



%get average drop error per participant per location= how tricky locations
%were
%%%%%%%%locationError=meandropLocation, NOT distance but LOCATION
for iSub=1:nSubs;
    for iPos=1:nPos;
        
        locationError(iPos,iSub)= mean(trial(:,iSub).dropDist(trial(:,iSub).cueID(trial(:,iSub).cueID==iPos)));
    end
end

figure
hold on
for iSub=1:nSubs;
    subplot(4,4,iSub);
    xlabel('Position');
    ylabel('Mean drop error');
    hold on
    plot(locationError(:,iSub),'ro');
end


%get average drop error per participant = how good they were

for iSub=1:nSubs;
    
    meanDropDist(iSub)= mean(trial(:,iSub).dropDist(1:nTrials(iSub)));
end

figure
hold on
for iSub=1:nSubs;
    plot(iSub, meanDropDist(1,iSub), 'bd');
end
hold on
xlabel('Participant')
ylabel('Mean drop error')


%%%correlation values betweem cue ID and drop Dist

for iSub = 1:nSubs;
    [corrValues(iSub), pCorr(iSub)] = corr(trial(:,iSub).dropDist, trial(:,iSub).cueID(1:nTrials(iSub)));
end

%%% ttest within subject for narrow and broad parts (using means)
pvalue_tt=nan(nPos,1);
civalues_tt=nan(nPos,2);
[h, pvalue_tt(1), civalues_tt(1,1:2)]=ttest(locationError(1,:), locationError(3,:));
[h, pvalue_tt(2), civalues_tt(2,1:2)]=ttest(locationError(5,:), locationError(7,:));
[h, pvalue_tt(3), civalues_tt(3,1:2)]=ttest(locationError(2,:), locationError(4,:));
[h, pvalue_tt(4), civalues_tt(4,1:2)]=ttest(locationError(2,:), locationError(8,:));
[h, pvalue_tt(5), civalues_tt(5,1:2)]=ttest(locationError(6,:), locationError(8,:));
[h, pvalue_tt(6), civalues_tt(6,1:2)]=ttest(locationError(2,:), locationError(6,:));
[h, pvalue_tt(7), civalues_tt(7,1:2)]=ttest(locationError(4,:), locationError(8,:));
[h, pvalue_tt(8), civalues_tt(8,1:2)]=ttest(locationError(4,:), locationError(6,:));

%%%% BARS

%mean for all subjects
figure
bar(mean(locationError'))
hold on
xlabel ('Position');
ylabel ('Mean error');

%for each subject separetaly

figure
for iSub=1:nSubs;
    subplot(4,4,iSub);
    xlabel('Position');
    ylabel('Mean error');
    for iSub=iSub
        bar(locationError(:,iSub))
    end
end


%% X AND Y SEPARATELY
%%% mean X and Y error for each position
for iSub=1:nSubs;
    for iPos=1:nPos;
        
        meanXerror(iPos,iSub)= mean(trial(:,iSub).droperrorX(trial(:,iSub).cueID(trial(:,iSub).cueID==iPos)));
        meanYerror(iPos,iSub)= mean(trial(:,iSub).droperrorY(trial(:,iSub).cueID(trial(:,iSub).cueID==iPos)));
        
    end
end

%%% ttest within subject for narrow and broad parts (using means of DROP ERROR in X
%%% dimension)
pvalueX_tt=nan(nPos,1);
civaluesX_tt=nan(nPos,2);
%meanXerror=abs(meanXerror);
[h, pvalueX_tt(1), civaluesX_tt(1,1:2)]=ttest(meanXerror(1,:), meanXerror(5,:));
[h, pvalueX_tt(2), civaluesX_tt(2,1:2)]=ttest(meanXerror(3,:), meanXerror(7,:));
[h, pvalueX_tt(3), civaluesX_tt(3,1:2)]=ttest(meanXerror(2,:), meanXerror(4,:));
[h, pvalueX_tt(4), civaluesX_tt(4,1:2)]=ttest(meanXerror(2,:), meanXerror(8,:));
[h, pvalueX_tt(5), civaluesX_tt(5,1:2)]=ttest(meanXerror(6,:), meanXerror(8,:));
[h, pvalueX_tt(6), civaluesX_tt(6,1:2)]=ttest(meanXerror(2,:), meanXerror(6,:));
[h, pvalueX_tt(7), civaluesX_tt(7,1:2)]=ttest(meanXerror(4,:), meanXerror(8,:));
[h, pvalueX_tt(8), civaluesX_tt(8,1:2)]=ttest(meanXerror(4,:), meanXerror(6,:));


%%% ttest within subject for narrow and broad parts (using means of DROP
%%% ERROR in Y
%%% dimension)
pvalueY_tt=nan(nPos,1);
civaluesY_tt=nan(nPos,2);
%meanYerror=abs(meanYerror);
[h, pvalueY_tt(1), civaluesY_tt(1,1:2)]=ttest(meanYerror(1,:), meanYerror(5,:));
[h, pvalueY_tt(2), civaluesY_tt(2,1:2)]=ttest(meanYerror(3,:), meanYerror(7,:));
[h, pvalueY_tt(3), civaluesY_tt(3,1:2)]=ttest(meanYerror(2,:), meanYerror(4,:));
[h, pvalueY_tt(4), civaluesY_tt(4,1:2)]=ttest(meanYerror(2,:), meanYerror(8,:));
[h, pvalueY_tt(5), civaluesY_tt(5,1:2)]=ttest(meanYerror(6,:), meanYerror(8,:));
[h, pvalueY_tt(6), civaluesY_tt(6,1:2)]=ttest(meanYerror(2,:), meanYerror(6,:));
[h, pvalueY_tt(7), civaluesY_tt(7,1:2)]=ttest(meanYerror(4,:), meanYerror(8,:));
[h, pvalueY_tt(8), civaluesY_tt(8,1:2)]=ttest(meanYerror(4,:), meanYerror(6,:));