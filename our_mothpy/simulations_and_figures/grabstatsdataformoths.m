clc;
clear variables;

detectthresh = 120:380:2400;
speed = 50:90:590;
molamount = [0.1:0.58:5.32 , 6.48 , 8.8, 13.44, 22.72 , 41.28];
timesimulated = 20;
puffreleaserate = 50:(200-50)/(10-1):200;

DT = length(detectthresh);
S = length(speed);
MA = length(molamount);
PRR = length(puffreleaserate);

%%% to load all files
successpercentage = zeros(DT,S,MA,PRR);
meanarrivaltime = successpercentage;
minarrivaltime = successpercentage;
for i=1:DT
    for j=1:S
        for k=1:MA
            filename = strcat('simulation_data/detectthresh-',num2str(detectthresh(i)),...
                '_speed-',num2str(speed(j)),'_molamount-',num2str(molamount(k)),...
                '_timesimulated-',num2str(timesimulated),'/statistics.json');
            
            statsdata = jsondecode(fileread(filename));
            
            successpercentage(i,j,k,:) = statsdata.statistics.successpercentage;
            meanarrivaltime(i,j,k,:) = statsdata.statistics.meanarrivaltime;
            minarrivaltime(i,j,k,:) = statsdata.statistics.minarrivaltime / timesimulated;
        end
    end
end

no_success = (successpercentage==0);
meanarrivaltime(no_success) = NaN;
minarrivaltime(no_success) = NaN;

maxSP = max(max(max(max(successpercentage))));
maxMeanT = max(max(max(max(meanarrivaltime))));
maxMinT = max(max(max(max(minarrivaltime))));

%% figures

%%% shift axes of pcolor so the boxes are centered on the mesh points
x = molamount;
y = puffreleaserate;
xSplit = diff(x)/2;
ySplit = diff(y)/2;
xEdges = [x(1)-xSplit(1) x(2:end)-xSplit x(end)+xSplit(end)];
xEdges(1) = 0;
yEdges = [y(1)-ySplit(1) y(2:end)-ySplit y(end)+ySplit(end)];
[xGrid, yGrid] = meshgrid(xEdges,yEdges);

fontsize = 12;

%%% Success Percentage plot
figure(1)
tiledlayout(S,DT,'TileSpacing','normal','Padding','compact');
for i=1:S
    i2 = S+1 - i;
    for j=1:DT
        nexttile
        j2 = DT+1 - j;
        SPreshape = reshape(successpercentage(j2,i2,:,:),[MA,PRR]);
        SPtranspose = SPreshape';
        SPplot = [[SPtranspose zeros(size(SPtranspose,1),1)] ;
            zeros(1,size(SPtranspose,2)+1)]; % Last row/col ignored
        pc = pcolor(xGrid,yGrid,SPplot);
        pc.EdgeColor = 'none';
        
        caxis([0,maxSP])
        if i==1 && j==S
            colorbar%(gca,'Position',[0.914910311178399 0.114464100594575 0.0096078901063974 0.792924036762345]);
        end
        if i==1
            % pheromone detection threshold
            title(['$C_\mathrm{tol}$ = ',num2str(detectthresh(j2)),' ng/m$^2$'],'Interpreter','latex')
        end
        if i==S
            xlabel('$m_p$ (ng)','Interpreter','latex')
            set(gca,'XTick',[10^0, 10^1])
        else
            set(gca,'XTicklabel',[])
        end
        if j==1
            % male speed
            ylabel({['\bf $v$ = ',num2str(speed(i2)),' cm/s'] ; '\rm $f_r$ (/s)'},'Interpreter','latex')
        else
            set(gca,'YTicklabel',[])
        end
        set(gca,'YDir','normal','XScale','log','FontSize',fontsize)
    end
end
%sgtitle('Success Percentage')
set(gcf,'Units','inches','Position',[2,2,13,10],'PaperPositionMode','auto')


%%% Mean Arrival Time plot
figure(2)
tiledlayout(S,DT,'TileSpacing','normal','Padding','compact');
for i=1:S
    i2 = S+1 - i;
    for j=1:DT
        nexttile
        j2 = DT+1 - j;
        MeanTreshape = reshape(meanarrivaltime(j2,i2,:,:),[MA,PRR]);
        MeanTtranspose = MeanTreshape';
        MeanTplot = [[MeanTtranspose zeros(size(MeanTtranspose,1),1)] ;
            zeros(1,size(MeanTtranspose,2)+1)]; % Last row/col ignored
        pc = pcolor(xGrid,yGrid,MeanTplot);
        pc.EdgeColor = 'none';
        
        caxis([0,maxMeanT])
        if i==1 && j==S
            colorbar%(gca,'Position',[0.914910311178399 0.114464100594575 0.0096078901063974 0.792924036762345]);
        end
        if i==1
            % pheromone detection threshold
            title(['$C_\mathrm{tol}$ = ',num2str(detectthresh(j2)),' ng/m$^2$'],'Interpreter','latex')
        end
        if i==S
            xlabel('$m_p$ (ng)','Interpreter','latex')
            set(gca,'XTick',[10^0, 10^1])
        else
            set(gca,'XTicklabel',[])
        end
        if j==1
            % male speed
            ylabel({['\bf $v$ = ',num2str(speed(i2)),' cm/s'] ; '\rm $f_r$ (/s)'},'Interpreter','latex')
        else
            set(gca,'YTicklabel',[])
        end
        set(gca,'YDir','normal','XScale','log','FontSize',fontsize)
    end
end
%sgtitle('Mean Arrival Time')
set(gcf,'Units','inches','Position',[2,2,13,10],'PaperPositionMode','auto')



%%% Minimum Arrival Time plot
figure(3)
tiledlayout(S,DT,'TileSpacing','normal','Padding','compact');
for i=1:S
    i2 = S+1 - i;
    for j=1:DT
        nexttile
        j2 = DT+1 - j;
        MinTreshape = reshape(minarrivaltime(j2,i2,:,:),[MA,PRR]);
        MinTtranspose = MinTreshape';
        MinTplot = [[MinTtranspose zeros(size(MinTtranspose,1),1)] ;
            zeros(1,size(MinTtranspose,2)+1)]; % Last row/col ignored
        pc = pcolor(xGrid,yGrid,MinTplot);
        pc.EdgeColor = 'none';
        
        caxis([0,1])
        if i==1 && j==S
            colorbar%(gca,'Position',[0.914910311178399 0.114464100594575 0.0096078901063974 0.792924036762345]);
        end
        if i==1
            % pheromone detection threshold
            title(['$C_\mathrm{tol}$ = ',num2str(detectthresh(j2)),' ng/m$^2$'],'Interpreter','latex')
        end
        if i==S
            xlabel('$m_p$ (ng)','Interpreter','latex')
            set(gca,'XTick',[10^0, 10^1])
        else
            set(gca,'XTicklabel',[])
        end
        if j==1
            % male speed
            ylabel({['\bf $v$ = ',num2str(speed(i2)),' cm/s'] ; '\rm $f_r$ (/s)'},'Interpreter','latex')
        else
            set(gca,'YTicklabel',[])
        end
        set(gca,'YDir','normal','XScale','log','FontSize',fontsize)
    end
end
%sgtitle('Minimum Arrival Time')
set(gcf,'Units','inches','Position',[2,2,13,10],'PaperPositionMode','auto')






%%% to load a single file (for double checking dimensions)
% successpercentage = zeros(MA,PRR);
% meanarrivaltime = successpercentage;
% minarrivaltime = successpercentage;
% DTindex = 5;
% Sindex = 5;
% 
% for k=1:MA
%     filename = strcat('simulation_data/detectthresh-',num2str(detectthresh(DTindex)),...
%         '_speed-',num2str(speed(Sindex)),'_molamount-',num2str(molamount(k)),...
%         '_timesimulated-',num2str(timesimulated),'/statistics.json');
%     
%     statsdata = jsondecode(fileread(filename));
%     
%     successpercentage(k,:) = statsdata.statistics.successpercentage;
%     meanarrivaltime(k,:) = statsdata.statistics.meanarrivaltime;
%     minarrivaltime(k,:) = statsdata.statistics.minarrivaltime;
% end
% 
% figure
% % imagesc(molamount,puffreleaserate,successpercentage')
% C = successpercentage';
% reshapeC = [[C zeros(size(C,1),1)] ; zeros(1,size(C,2)+1)];% Last row/col ignored
% pc = pcolor(xGrid,yGrid,reshapeC);
% pc.EdgeColor = 'none';
% colorbar
% title(['Male Speed = ',num2str(speed(Sindex))])
% xlabel('Molecular Amount')
% ylabel({['\bf Threshold = ',num2str(detectthresh(DTindex))] ; ...
%     '\rm Puff Release Rate'})
% set(gca,'YDir','normal')
