
oData = QPICData('Silent','Yes');
iTime = 1601;
iAvg  = 1;

fMain = figure(12); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[650 400]);

clear nSet;
clear sSet;
clear aCurr;
clear aQTot;
clear aQEmt;
clear aMMom;
clear aRMom;
clear eQEmt;
clear eMMom;
clear eRMom;
clear aTQ;
clear aTM;
clear aTR;

cCol  = lines(2);
cSims = {'07A','21A','21B','21C','21D', ...
         '20A','21E','21F','21G','21H', ...
         '20B','21I','21J','21K','21L', ...
         '20C','21M','21N','21O','21P', ...
         '20D'};
aOff  = linspace(0,4,numel(cSims))*5.2454;
%aRad  = sqrt(dLFac*aEmit*sqrt(2*dGamma)/dGamma)*1e3;

for n=1:17

    oData.Path = sprintf('PPE-Q%s', cSims{n});

    stInfo   = oData.BeamInfo(1);
    aCurr(n) = abs(stInfo.Current);
    aQTot(n) = abs(stInfo.Charge);

    dGamma = oData.Config.Beam.Beam01.Gamma;
    dMe    = oData.Config.Constants.EV.ElectronMass;
    dLFac  = oData.Config.Convert.SI.LengthFac;
    dTStep = oData.Config.Simulation.TimeStep;
    dBeta  = sqrt(2*dGamma)*dLFac;

    oBeam = QPICBeam(oData,1,'Units','SI');
    
    for a=1:iAvg
        
        fprintf('Processing Sim %02d, Time %04d\n', n, iTime - 10*(a-1));
        
        oBeam.Time = iTime - 10*(a-1);
        stPS  = oBeam.SlicedPhaseSpace('EmitTol',5,'ReturnInc','Yes');
        if ~isempty(stPS.Error)
            i = i - 1;
            break;
        end % if
        aTQ(a) = abs(stPS.TolCharge);
        aTM(a) = mean(stPS.Included(:,4))-dGamma;
        aTR(a) = std(stPS.Included(:,4));
    end % for

    aQEmt(n) = mean(aTQ);
    aMMom(n) = mean(aTM);
    aRMom(n) = mean(aTR);
    eQEmt(n) = std(aTQ);
    eMMom(n) = std(aTM);
    eRMom(n) = std(aTR);

    figure(12); clf;

    yyaxis left;
    plot(aOff(1:n),(aQEmt./aQTot)*100,'LineStyle','-','Marker','o','MarkerFaceColor',cCol(1,:));
    %plot(aEmit(1:n),(aQEmt./aQTot)*100,'LineStyle','-');
    %errorbar(aEmit(1:n),(aQEmt./aQTot)*100,(eQEmt./aQTot)*100,'LineStyle','None','Marker','+');

    ylim([0 100]);
    %ylabel('\{n \in N_{eb} : \epsilon_N \leq 2.1µm\} [%]');
    ylabel('~Q_{eb}/Q_{eb} [%]');

    yyaxis right;
    plot(aOff(1:n),(aRMom./aMMom)*100,'LineStyle','-','Marker','o','MarkerFaceColor',cCol(2,:));
    %plot(aEmit(1:n),(aRMom./aMMom)*100,'LineStyle','-');
    %errorbar(aEmit(1:n),(aRMom./aMMom)*100,(eRMom./aMMom)*100,'LineStyle','None','Marker','+');

    ylim([0 9]);
    ylabel('E_{rms} / \langle\DeltaE\rangle [%]');

    xlabel('\Deltax [µm]');
    xlim([aOff(1)-0.2 aOff(17)+0.2]);

    drawnow;

end % for
