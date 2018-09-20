
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
sSims = 'ABCDEFGHIJKLMNOPQRSTUVWX';
aEmit = 10.^(-1:0.1301:2.0);
%aRad  = sqrt(dLFac*aEmit*sqrt(2*dGamma)/dGamma)*1e3;

for n=3:22

    oData.Path = sprintf('PPE-Q19%s', sSims(n));

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

    clf;

    yyaxis left;
    plot(aEmit(1:n),(aQEmt./aQTot)*100,'LineStyle','-','Marker','o','MarkerFaceColor',cCol(1,:));
    %plot(aEmit(1:n),(aQEmt./aQTot)*100,'LineStyle','-');
    %errorbar(aEmit(1:n),(aQEmt./aQTot)*100,(eQEmt./aQTot)*100,'LineStyle','None','Marker','+');

    ylim([0 100]);
    %ylabel('\{n \in N_{eb} : \epsilon_N \leq 2.1µm\} [%]');
    ylabel('~Q_{eb}/Q_{eb} [%]');

    yyaxis right;
    plot(aEmit(1:n),(aRMom./aMMom)*100,'LineStyle','-','Marker','o','MarkerFaceColor',cCol(2,:));
    %plot(aEmit(1:n),(aRMom./aMMom)*100,'LineStyle','-');
    %errorbar(aEmit(1:n),(aRMom./aMMom)*100,(eRMom./aMMom)*100,'LineStyle','None','Marker','+');

    ylim([0 18]);
    ylabel('E_{rms} / \langle\DeltaE\rangle [%]');

    xlim([1.5e-1 0.68e2]);
    set(gca,'XScale','Log');
    xticks([0.1 0.2 0.5 1 2 5 10 20 50 100]);
    xlabel('\epsilon_{N} [µm]');
    
    %title(sprintf('At z = %0.2f m',iTime*dTStep*dLFac));

    drawnow;

end % for
