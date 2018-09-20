
iTime = 1;

oData = QPICData;

oData.Path = 'PPE-Q14B';
aFE0  = oData.Data(iTime,'F','EZ','','XZ');

oData.Path = 'PPE-Q13A';

dE0   = oData.Config.Convert.SI.E0;
dB0   = oData.Config.Convert.SI.B0;
dN0   = oData.Config.Simulation.N0;
aGrid = oData.Config.Simulation.Grid;
aSize = oData.Config.Simulation.XMax;
aRes  = aSize./aGrid;

aZAxis = linspace(0,aSize(1),aGrid(1))*1e3;
aXAxis = linspace(-aSize(2)/2,aSize(2)/2,aGrid(2))*1e6;

aDenPE = oData.Data(iTime,'Q','','EP01','XZ');
aDenEB = oData.Data(iTime,'Q','','EB','XZ');
aDenPB = oData.Data(iTime,'Q','','EB','XZ');
aFEZ   = oData.Data(iTime,'F','EZ','','XZ');
aFEX   = oData.Data(iTime,'F','EX','','XZ');
aFBY   = oData.Data(iTime,'F','BY','','XZ');

aDenEB(aDenEB >  0.0) =  0.0;
aDenPB(aDenPB <  0.0) =  0.0;

aDenPE(aDenPE < -4.0) = -4.0;
aDenEB(aDenEB < -5.0) = -5.0;
aDenPB(aDenPB >  0.1) =  0.1;

aDenPE = aDenPE/4.0;
aDenEB = aDenEB/5.0;
aDenPB = aDenPB/0.1;

aLnEZ  = aFEZ(517,:)*dE0*1e-6;
aLnE0  = aFE0(517,:)*dE0*1e-6;
aLnEX  = (aFEX(514,:)-aFEX(513,:))/aRes(2)*dB0*1e-3;
aLnBY  = (aFBY(514,:)-aFBY(513,:))/aRes(2)*dB0*1e-3;
aLnWX  = aLnEX - aLnBY;

figure(2); clf;
fFigureSize(gcf,[650 400]);

cRed  = [linspace(0.850,0.850,256); linspace(0.325,1,256); linspace(0.098,1.000,256)]';
cBlue = [linspace(0.000,1.000,256); linspace(0.447,1,256); linspace(0.741,0.741,256)]';
cMap  = [cRed; flipud(cBlue)];
cLine = lines;


hold on;

yyaxis left;

caxis([-1 0]);
h1 = imagesc(aZAxis,aXAxis,aDenPE);
colormap(gray);
freezeColors;

caxis([-1 1]);
h2 = imagesc(aZAxis,aXAxis,aDenEB);
colormap(cMap);
set(h2,'AlphaData',-aDenEB);
freezeColors;

h3 = imagesc(aZAxis,aXAxis,aDenPB);
set(h3,'AlphaData', aDenPB);
freezeColors;

ylim([aXAxis(1) aXAxis(end)]);
ylabel('x [µm]');

%set(gca,'XColor',[1 1 1],'YColor',[1 1 1],'Color','none');
%set(gcf,'Color','none','Inverthardcopy','off');

yyaxis right;

%plot(aZAxis,aLnE0,'Color',[0.00 0.40 0.00],'LineStyle','--');
%plot(aZAxis,aLnEZ,'Color',[0.00 0.40 0.00],'LineStyle','-');
plot(aZAxis,aLnWX,'Color',[0.40 0.10 0.00],'LineStyle','-');

%ylim([-600 600]);
ylim([-30 30]);
ylabel('dW_x/dx [kT/m]');

hold off;

h9 = legend({'dW_x/dx'}, 'Location', 'SW');
set(h9,'Box','Off');
set(h9,'TextColor', 'Black');


xlim([aZAxis(1) aZAxis(end)]);
xlabel('\xi [mm]');

