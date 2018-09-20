iTime = 1601;

oData = QPICData;

oData.Path = 'PPE-Q13A';
dLFac  = oData.Config.Convert.SI.LengthFac;
dEMass = oData.Config.Constants.EV.ElectronMass;

aRaw = oData.Data(iTime,'RAW','','EB01','');

figure(3); clf;
fFigureSize(gcf,[650 320]);

aData = [aRaw(:,4) aRaw(:,1)];
aWeights = ones(size(aRaw(:,1)));
aGrid = [500 500];

dPMean = mean(aRaw(:,4));
dPStd  = std(aRaw(:,4));

aCut = aRaw(aRaw(:,1) > 1.45e-3/dLFac,4);

dCMean = mean(aCut);
dCStd  = std(aCut);

stData = QPICProcess.fDeposit(aData,aWeights,1,aGrid);

aHist  = stData.Deposit;
aLims  = stData.Limits;
aXProj = sum(aHist,1);
aYProj = sum(aHist,2);

aXAxis = linspace(aLims(1,2),aLims(2,2),aGrid(1))*dLFac*1e3;
aYAxis = linspace(aLims(1,1),aLims(2,1),aGrid(2));
aYAxis = sqrt(aYAxis.^2 - 1)*dEMass*1e-9;

dPMean = sqrt(dPMean^2 - 1)*dEMass*1e-9
dPStd  = sqrt(dPStd^2 - 1)*dEMass*1e-9
dPRat  = dPStd/dPMean

dCMean = sqrt(dCMean^2 - 1)*dEMass*1e-9
dCStd  = sqrt(dCStd^2 - 1)*dEMass*1e-9
dCRat  = dCStd/dCMean

aXLim  = [1.25 1.75];
aYLim  = [1.20 1.80];

dXFac  = 0.2*(aYLim(2) - aYLim(1));
dYFac  = 0.2*(aXLim(2) - aXLim(1));

aHist(aHist > 500) = 500;
aXProj = aXProj/max(aXProj)*dXFac+aYLim(1);
aYProj = aYProj/max(aYProj)*dYFac+aXLim(1);


cGrey = [linspace(1.000,0.000,256); linspace(1.000,0.000,256); linspace(1.000,0.000,256)]';

hold on;

imagesc(aXAxis, aYAxis, aHist);
set(gca,'YDir','Normal');
colormap(cGrey);

plot(aXAxis,aXProj);
line([1.45 1.45],[1.2 1.8],'Color',[0.4940 0.1840 0.5560]);

hold off;

xlim(aXLim);
ylim(aYLim);

xlabel('\xi [mm]');
ylabel('P_z [GeV/c]');

aPos = get(gca,'Position');

axes('Position',aPos,'Color','None');
plot(aYAxis,aYProj);
set(gca,'Color','None');
view([90 -90]);

xlim(aYLim);
ylim(aXLim);

set(gca,'XTickLabel',{})
set(gca,'YTickLabel',{})


