
%
% Stills
%

oData = QPICData;

aTime = [1 401 1001 1 401 1001];
aPos  = [1 1 1 2 2 2];
aFigs = [10 11 12 13 14 15];

oData.Path = 'PPE-Q14A';

dLFac  = oData.Config.Convert.SI.LengthFac;
dTStep = oData.Config.Simulation.TimeStep;
dEMass = oData.Config.Constants.EV.ElectronMass;

cMap1 = [linspace(1.000,0.000,256); linspace(1.000,0.447,256); linspace(1.000,0.741,256)]';
cMap2 = [linspace(1.000,0.850,256); linspace(1.000,0.325,256); linspace(1.000,0.098,256)]';

cMap = cat(3,cMap1,cMap2);

fMain = figure(9); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[1300 400]);

aAxes(1) = axes('Units','Pixels','Position',[ 65 225 190 165]);
aAxes(2) = axes('Units','Pixels','Position',[260 225 190 165]);
aAxes(3) = axes('Units','Pixels','Position',[455 225 190 165]);
aAxes(4) = axes('Units','Pixels','Position',[ 65  50 190 165]);
aAxes(5) = axes('Units','Pixels','Position',[260  50 190 165]);
aAxes(6) = axes('Units','Pixels','Position',[455  50 190 165]);
aAxes(7) = axes('Units','Pixels','Position',[720 225 570 165]);
aAxes(8) = axes('Units','Pixels','Position',[720  50 570 165]);

sFigs = 'abcdef';

for i=1:numel(aTime)

    aRaw   = oData.Data(aTime(i),'RAW','','EB01','');
    if aPos(i) == 1
        aRaw(aRaw(:,1) < 1.40e-3/dLFac | aRaw(:,1) > 1.42e-3/dLFac,:) = [];
    else
        aRaw(aRaw(:,1) < 1.55e-3/dLFac | aRaw(:,1) > 1.57e-3/dLFac,:) = [];
    end % if

    aData  = [aRaw(:,5) aRaw(:,2)];
    aWghts = ones(size(aRaw(:,1)));
    aGrid  = [200 300];

    dPMean = mean(aRaw(:,5));
    dPStd  = std(aRaw(:,5));

    aXLim  = [-30 30];
    aYLim  = [-800 800];

    dXFac  = 0.2*(aYLim(2) - aYLim(1));
    dYFac  = 0.2*(aXLim(2) - aXLim(1));
    
    aHLims = [aYLim/dEMass/1e-3 (aXLim+600)/dLFac/1e6];

    stData = QPICProcess.fDeposit(aData,aWghts,1,aGrid,aHLims);

    aHist  = stData.Deposit;
    aLims  = stData.Limits;
    aXProj = sum(aHist,1);
    aYProj = sum(aHist,2);

    aXAxis = linspace(aLims(1,2),aLims(2,2),aGrid(1))*dLFac*1e6;
    aYAxis = linspace(aLims(1,1),aLims(2,1),aGrid(2));
    aXAxis = aXAxis - 600;
    aYAxis = aYAxis*dEMass*1e-3;

    dPMean = dPMean*dEMass*1e-3;
    dPStd  = dPStd*dEMass*1e-3;
    dPRat  = dPStd/dPMean;

    aHist(aHist > 500) = 500;
    aXProj = aXProj/max(aXProj)*dXFac+aYLim(1);
    aYProj = aYProj/max(aYProj)*dYFac+aXLim(1);

    axes(aAxes(i));

    imagesc(aXAxis, aYAxis, aHist);
    set(gca,'YDir','Normal');
    colormap(cMap(:,:,aPos(i)));

    xlim(aXLim);
    ylim(aYLim);
    caxis([0 4]);

    freezeColors;
    
    if i < 4
        set(gca,'XTick', []);
    else
        xlabel('x [µm]');
    end % if
    
    if i ~= 1 && i ~= 4
        set(gca,'YTick', []);
    else
        ylabel('P_x [keV/c]');
    end % if
    
    sPos = sprintf('z = %.1f m',aTime(i)*dTStep*dLFac);
    text(-28,700,sPos);
    text( 24,700,sFigs(i),'FontSize',12,'FontWeight','Bold');

    drawnow;

end % for

%
% Pos
%

aTime = 1:1:1401;

oData.Path = 'PPE-Q14A';
dLFac  = oData.Config.Convert.SI.LengthFac;
dTStep = oData.Config.Simulation.TimeStep;
dEMass = oData.Config.Constants.EV.ElectronMass;

aAxis = linspace(aTime(1), aTime(end), numel(aTime))*dTStep*dLFac;

clear aMean;
clear aStd;

hWait = waitbar(0, 'Scanning ...');

for i=1:numel(aTime)

    aRaw  = oData.Data(aTime(i),'RAW','','EB01','');
    aRawA = aRaw;
    aRawB = aRaw;
    aRawA(aRawA(:,1) < 1.40e-3/dLFac | aRawA(:,1) > 1.42e-3/dLFac,:) = [];
    aRawB(aRawB(:,1) < 1.55e-3/dLFac | aRawB(:,1) > 1.57e-3/dLFac,:) = [];

    aMean(1,i) = mean(aRawA(:,2))*dLFac*1e6 - 600;
    aMean(2,i) = mean(aRawB(:,2))*dLFac*1e6 - 600;
    aStd(1,i)  = std(aRawA(:,2))*dLFac*1e6;
    aStd(2,i)  = std(aRawB(:,2))*dLFac*1e6;
    
    waitbar(i/numel(aTime));

end % for

close(hWait);

axes(aAxes(7));

plot(aAxis,aMean);

set(gca,'XTick', []);
ylabel('MEAN(x) [µm]');
hYL7 = get(gca,'YLabel');

xlim([aAxis(1) aAxis(end)]);
ylim([-14 14]);

text(3.37,12.5,'g','FontSize',12,'FontWeight','Bold');

axes(aAxes(8));

plot(aAxis,aStd);

xlabel('z [m]');
ylabel('RMS(x) [µm]');
hYL8 = get(gca,'YLabel');

xlim([aAxis(1) aAxis(end)]);
ylim([2 13]);

text(3.37,12.2,'h','FontSize',12,'FontWeight','Bold');

set(hYL7,'Position',[-0.2 0.0 -1]);
set(hYL8,'Position',[-0.2 7.5 -1]);

