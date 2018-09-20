
iTimeA = 1;
iTimeB = 1601;
iTimeC = 16001;
iTimeD = 40041;

oData = QPICData;

oData.Path = 'PPE-Q13D';

dLFac  = oData.Config.Convert.SI.LengthFac;
dTStep = oData.Config.Simulation.TimeStep;
dZMax  = oData.Config.Simulation.XMax(1);
aGrid  = oData.Config.Simulation.Grid;
dE0    = oData.Config.Convert.SI.E0;
dN0    = oData.Config.Simulation.N0;
dPos   = oData.Config.Beam.Beam01.Position(1)/dLFac;
dSz    = oData.Config.Beam.Beam01.Profile(1)/dLFac;
dDz    = dZMax/double(aGrid(1))/dLFac;

iMinZ  = round((dPos - dSz*5)/dDz);
iMaxZ  = round((dPos + dSz*5)/dDz);
iMid   = round(dPos/dDz);

iMinZ  = round((dPos - dSz*5)/dDz);
iMaxZ  = round((dPos + dSz*5)/dDz);
iMid   = round(dPos/dDz);

aDenEBA  = oData.Data(iTimeA,'Q','','EB','XZ');
aDenEBB  = oData.Data(iTimeB,'Q','','EB','XZ');
aDenEBC  = oData.Data(iTimeC,'Q','','EB','XZ');
aDenEBD  = oData.Data(iTimeD,'Q','','EB','XZ');
aDenPEA  = oData.Data(iTimeA,'Q','','EP01','XZ');
aDenPEB  = oData.Data(iTimeB,'Q','','EP01','XZ');
aDenPEC  = oData.Data(iTimeC,'Q','','EP01','XZ');
aDenPED  = oData.Data(iTimeD,'Q','','EP01','XZ');

[dMaxA,iMaxA] = max(abs(aDenEBA(:,iMid)));
[dMaxB,iMaxB] = max(abs(aDenEBB(:,iMid)));
[dMaxC,iMaxC] = max(abs(aDenEBC(:,iMid)));
[dMaxD,iMaxD] = max(abs(aDenEBD(:,iMid)));

aLineEBA = abs(aDenEBA(iMaxA,:));
aLineEBB = abs(aDenEBB(iMaxB,:));
aLineEBC = abs(aDenEBC(iMaxC,:));
aLineEBD = abs(aDenEBD(iMaxD,:));
aLinePEA = abs(aDenPEA(iMaxA,:))*100;
aLinePEB = abs(aDenPEB(iMaxB,:))*100;
aLinePEC = abs(aDenPEC(iMaxC,:))*100;
aLinePED = abs(aDenPED(iMaxD,:))*100;

oBeam  = QPICBeam(oData,1,'Units','SI','Scale','mm');

oBeam.Time = iTimeA;
stData  = oBeam.SlicedPhaseSpace('Lim',[iMinZ iMaxZ]);
aEmittA = stData.ENorm;
aZAxis  = stData.Axis;

oBeam.Time = iTimeB;
stData  = oBeam.SlicedPhaseSpace('Lim',[iMinZ iMaxZ]);
aEmittB = stData.ENorm;

oBeam.Time = iTimeC;
stData  = oBeam.SlicedPhaseSpace('Lim',[iMinZ iMaxZ]);
aEmittC = stData.ENorm;

oBeam.Time = iTimeD;
stData  = oBeam.SlicedPhaseSpace('Lim',[iMinZ iMaxZ]);
aEmittD = stData.ENorm;

aLineEBA = aLineEBA(iMinZ:iMaxZ);
aLineEBB = aLineEBB(iMinZ:iMaxZ);
aLineEBC = aLineEBC(iMinZ:iMaxZ);
aLineEBD = aLineEBD(iMinZ:iMaxZ);
aLinePEA = aLinePEA(iMinZ:iMaxZ);
aLinePEB = aLinePEB(iMinZ:iMaxZ);
aLinePEC = aLinePEC(iMinZ:iMaxZ);
aLinePED = aLinePED(iMinZ:iMaxZ);

cLegend{1} = sprintf('z = %.0f m\n',iTimeA*dTStep*dLFac);
cLegend{2} = sprintf('z = %.0f m\n',iTimeB*dTStep*dLFac);
cLegend{3} = sprintf('z = %.0f m\n',iTimeC*dTStep*dLFac);
cLegend{4} = sprintf('z = %.0f m\n',iTimeD*dTStep*dLFac);

figure(5); clf;
fFigureSize(gcf,[650 350]);
cMap = lines;

hold on;

yyaxis left;
hPE1 = plot(aZAxis,aLinePEA,'Color',[0.00 0.40 0.00],'LineStyle','-');
hPE2 = plot(aZAxis,aLinePEB,'Color',[0.00 0.40 0.00],'LineStyle','--');
hPE3 = plot(aZAxis,aLinePEC,'Color',[0.00 0.40 0.00],'LineStyle','-.');
hPE4 = plot(aZAxis,aLinePED,'Color',[0.00 0.40 0.00],'LineStyle',':');
hEB1 = plot(aZAxis,aLineEBA,'LineStyle','-', 'Marker','none');
hEB2 = plot(aZAxis,aLineEBB,'LineStyle','--','Marker','none');
hEB3 = plot(aZAxis,aLineEBC,'LineStyle','-.','Marker','none');
hEB4 = plot(aZAxis,aLineEBD,'LineStyle',':', 'Marker','none');

ylabel('Beam [n_{b}/n_{0}] \color[rgb]{0,0,0} & \color[rgb]{0,0.4,0} Plasma [100\timesn_{pe}/n_{0}]','FontSize',10.5);
ylim([0 400]);

text(1.26,375,'Offset Beam','FontSize',12);

yyaxis right;
hEM1 = stairs(aZAxis,aEmittA,'LineStyle','-');
hEM2 = stairs(aZAxis,aEmittB,'LineStyle','--');
hEM3 = stairs(aZAxis,aEmittC,'LineStyle','-.');
hEM4 = stairs(aZAxis,aEmittD,'LineStyle',':');

ylabel('\epsilon_x [µm]','FontSize',10.5);
ylim([0 7.1]);

hold off;

xlabel('\xi [mm]');
xlim([1.25 1.73]);
hL = legend([hEB1 hEB2 hEB3 hEB4],cLegend,'Location','NE');
set(hL,'Box','Off');
