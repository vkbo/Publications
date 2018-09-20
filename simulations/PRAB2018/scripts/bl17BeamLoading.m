
iTime = 1;

oData = QPICData;
oData.Path = 'PPE-Q14B';

dE0   = oData.Config.Convert.SI.E0;
dN0   = oData.Config.Simulation.N0;
aGrid = oData.Config.Simulation.Grid;
aSize = oData.Config.Simulation.XMax;

aAxis = linspace(0,aSize(1),aGrid(1))*1e3;

aEZEBOff   = oData.Data(iTime,'F','EZ','','XZ');
aDenPEOff  = oData.Data(iTime,'Q','','EP01','XZ');

aLineEBOff = mean(aEZEBOff(512:513,:),1)*dE0*1e-6;
aLinePEOff = mean(aDenPEOff(512:513,:),1);

oData.Path = 'PPE-Q14C';

aEZPBOff   = oData.Data(iTime,'F','EZ','','XZ');
aDenPPOff  = oData.Data(iTime,'Q','','EP01','XZ');

aLinePBOff = mean(aEZPBOff(512:513,:),1)*dE0*1e-6;
aLinePPOff = mean(aDenPPOff(512:513,:),1);

oData.Path = 'PPE-Q13A';

aEZEBOn    = oData.Data(iTime,'F','EZ','','XZ');
aQBEBOn    = oData.Data(iTime,'Q','','EB','XZ');
aDenPEOn   = oData.Data(iTime,'Q','','EP01','XZ');

aLineEBOn  = mean(aEZEBOn(512:513,:),1)*dE0*1e-6;
aLineQBOn  = abs(mean(aQBEBOn(512:513,:),1));
aLinePEOn  = mean(aDenPEOn(512:513,:),1);

% Calculate beam profiles
aProEB = oData.Config.Beam.Beam01.Profile;
aProPB = oData.Config.Beam.Beam02.Profile;
aPosEB = oData.Config.Beam.Beam01.Position;
aPosPB = oData.Config.Beam.Beam02.Position;
dNEB   = oData.Config.Beam.Beam01.NumParticles;
dNPB   = oData.Config.Beam.Beam02.NumParticles;
dMaxEB = double(dNEB)/(2*pi)^(3/2)/prod(aProEB)/dN0;
dMaxPB = double(dNPB)/(2*pi)^(3/2)/prod(aProPB)/dN0;

aDenEB = dMaxEB*exp(-(aAxis-aPosEB(1)*1e3).^2/(2*(aProEB(1)*1e3)^2));
aDenPB = dMaxPB*exp(-(aAxis-aPosPB(1)*1e3).^2/(2*(aProPB(1)*1e3)^2));

figure(1); clf;
fFigureSize(gcf,[650 480]);
cMap = lines;

hTop = subplot(3,1,1:2);

hold on;

yyaxis left;

%plot(aAxis,aLinePBOff,'Color',cMap(1,:),'LineStyle','-.');
plot(aAxis,aLineEBOff,'Color',cMap(1,:),'LineStyle','--');
plot(aAxis,aLineEBOn,'Color',cMap(1,:),'LineStyle','-');

ylim([-500 500]);
set(gca,'YTick',[-500 -250 0 250 500]);
ylabel('E_z [MeV]');

yyaxis right;

%plot(aAxis,aLineQBOn,'Color',cMap(2,:),'LineStyle','-');
plot(aAxis,aDenEB+aDenPB,'Color',cMap(2,:),'LineStyle','-');

ylim([0 40]);
ylabel('Beam [n_{b}/n_0]');

hold off;

hAnn = annotation('textarrow',[0.20 0.15],[0.70 0.70],'String','v = c');
hAnn.HeadWidth  = 6;
hAnn.HeadLength = 6;

hL = legend({'Unloaded field','Loaded field','Beam density'},'Location','NW');
set(hL,'Box','Off');
aPos = hL.Position;
hL.Position = aPos - [0.015 -0.02 0.0 0.0];

%xlim([aAxis(1) aAxis(end)]);
xlim([0.1 2.1]);
set(gca,'XTickLabel',{})


hBtm = subplot(3,1,3);

hold on;

yyaxis left;
set(gca,'YTickLabel',{})

yyaxis right;

plot(aAxis,-aLinePPOff,'Color',[0.00 0.40 0.00],'LineStyle','-.');
plot(aAxis,-aLinePEOff,'Color',[0.00 0.40 0.00],'LineStyle','--');
plot(aAxis,-aLinePEOn, 'Color',[0.00 0.40 0.00],'LineStyle','-');

ylim([-0.1 2.1]);
ylabel('Plasma [n_{pe}/n_0]');

hold off;

hL = legend({'No protons','No electrons','Both beams'},'Location','SW');
set(hL,'Box','Off');
aPos = hL.Position;
hL.Position = aPos - [0.015 0.02 0.0 0.0];

%xlim([aAxis(1) aZAxis(end)]);
xlim([0.1 2.1]);
xlabel('\xi [mm]');

aPos = hBtm.Position;
hBtm.Position = aPos + [0.0 0.0 0.0 0.05];

