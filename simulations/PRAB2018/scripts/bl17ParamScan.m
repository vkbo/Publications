
oData = QPICData('Silent','Yes');

iTime = 1601;

fMain = figure(10); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[650 400]);

clear nSet;
clear sSet;
clear aCurr;
clear aQTot;
clear aQEmt;
clear aMMom;
clear aRMom;

sMark = {'o','s','d','p','h'};
cCol  = lines(2);

cFiles = {'Q17N','Q17O','Q17C','Q17P','Q09A','Q18A','Q09B','Q18B','Q09C','Q18C','Q09D','Q18D','Q09E'; ...
          'Q17Q','Q17R','Q17E','Q17S','Q07A','Q18E','Q07B','Q18F','Q07C','Q18G','Q07D','Q18H','Q07E'; ...
          'Q17T','Q17U','Q17G','Q17V','Q10A','Q18I','Q10B','Q18J','Q10C','Q18K','Q10D','Q18L','Q10E'; ...
          'Q17W','Q17X','Q17I','Q17Y','Q11A','Q18M','Q11B','Q18N','Q11C','Q18O','Q11D','Q18P','Q11E'};

[nN,nS] = size(cFiles);

for n=1:nN
    for s=1:nS

        oData.Path = sprintf('PPE-%s', cFiles{n,s});

        stInfo     = oData.BeamInfo(1);
        aCurr(s,n) = abs(stInfo.Current);
        aQTot(s,n) = abs(stInfo.Charge);
        
        dGamma = oData.Config.Beam.Beam01.Gamma;
        dMe    = oData.Config.Constants.EV.ElectronMass;

        oBeam = QPICBeam(oData,1,'Units','SI');
        oBeam.Time = iTime;
        stPS  = oBeam.SlicedPhaseSpace('EmitTol',5,'ReturnInc','Yes');
        aQEmt(s,n) = abs(stPS.TolCharge);
        %aMMom(s,n) = stPS.MeanMom;
        %aRMom(s,n) = stPS.RMSMom;
        
        aMMom(s,n) = mean(stPS.Included(:,4))-dGamma;
        aRMom(s,n) = std(stPS.Included(:,4));
        
        aAxis = aQTot*1e12;

        clf;
        
        yyaxis left;

        hold on;
        for p=1:n
            plot(aAxis(:,p), (aQEmt(:,p)./aQTot(:,p))*100,'LineStyle','-','Marker',sMark{p},'MarkerFaceColor',cCol(1,:));
        end % for
        hold off;

        ylim([0 100]);
        %ylabel('\{n \in N_{eb} : \epsilon_N \leq 2.1µm\} [%]');
        ylabel('~Q_{eb}/Q_{eb} [%]');
        
        yyaxis right;
        hold on;
        for p=1:n
            plot(aAxis(:,p), (aRMom(:,p)./aMMom(:,p))*100,'LineStyle','-','Marker',sMark{p},'MarkerFaceColor',cCol(2,:));
        end % for
        hold off;

        ylim([0 16.2]);
        ylabel('E_{rms} / \langle\DeltaE\rangle [%]');
        
        xlim([0 310]);
        xlabel('Q_{eb} [pC]');
        
        drawnow;

    end % for
end % for

yyaxis left;

[hLeg,hObj] = legend({'40 µm','60 µm','80 µm','100 µm'},'Location','SE','Box','Off');
for o=1:4
    hObj(o).Position(1) = 0.980;
    hObj(o).HorizontalAlignment = 'Right';
end % for

% Secondary Figure

fMain = figure(11); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[650 400]);

yyaxis left;

hold on;
for p=1:n
    plot(aAxis(:,p),aQEmt(:,p)*1e12,'LineStyle','-','Marker',sMark{p},'MarkerFaceColor',cCol(1,:));
end % for
hold off;

%ylim([0 100]);
%ylabel('\{q \in Q_{eb} : \epsilon_N \leq 2.1µm\} [pC]');
ylabel('~Q_{eb} [pC]');

yyaxis right;
hold on;
for p=1:n
    plot(aAxis(:,p),(sqrt(aMMom(:,p).^2 + 1)+dGamma)*dMe*1e-9,'LineStyle','-','Marker',sMark{p},'MarkerFaceColor',cCol(2,:));
end % for
hold off;

%ylim([0 16.2]);
ylabel('\langleE\rangle [GeV]');

xlim([0 310]);
xlabel('Q_{eb} [pC]');

yyaxis left;

[hLeg,hObj] = legend({'40 µm','60 µm','80 µm','100 µm'},'Position',[0.4404 0.1500 0.1508 0.1637],'Box','Off');
for o=1:4
    hObj(o).Position(1) = 0.980;
    hObj(o).HorizontalAlignment = 'Right';
end % for
