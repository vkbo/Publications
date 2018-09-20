
%
%  E-Fields Figure
% *******************
%  For IPAC'15 Paper
%

function pubIPAC15FigureEFields(sMode)

    figMain = figure(20); clf;

    switch(lower(sMode))
        case 'paper'
            fFigureSize(figMain,[500 450]);
            set(figMain,'InvertHardCopy','Off');
            set(figMain,'Color',[1.0 1.0 1.0]);
        case 'poster'
            fFigureSize(figMain,[900 700]);
            set(figMain,'InvertHardCopy','Off');
            set(figMain,'Color',[1.0 1.0 0.894]);
        case 'presentation'
            fFigureSize(figMain,[900 500]);
    end % dwitch
    aM = get(figMain,'Position');
    
    stOD = {'PPE-U03B','PPE-U03C','PPE-U03D','PPE-U03E'};
    
    % Calculate Axes
    aPos = zeros(4,4);
    for i=1:4
        aPos(i,:) = [62 0 aM(3)-72 (aM(4)-62)*0.25];
    end % for
    
    aPos(4,2) = 45;
    for i=3:-1:1
        aPos(i,2) = aPos(i+1,2)+aPos(i+1,4)+5;
    end % for

    aYLim  = [-450 450];
    aXLim  = [10 14];
    
    % Figure One
    for p=1:4
        axM = axes('Units','Pixels','Position',aPos(p,:));

        oData = OsirisData('Silent','Yes');
        oData.Path = stOD{p};

        stData  = oData.BeamInfo('EB');
        dI      = stData.Current;
        [dI,sI] = fAutoScale(dI,'A');
        sLegend = sprintf('Î_{EB} = %.2f %s',dI,sI);

        oBeam       = Charge(oData,'EB','Units','SI','X1Scale','mm','X2Scale','mm');
        oBeam.X1Lim = aXLim;

        oBeam.Time  = 20;
        stBeam      = oBeam.Density;
        aProj1      = abs(sum(stBeam.Data));
        aProj1      = 0.30*(aYLim(2)-aYLim(1))*aProj1/max(abs(aProj1))+aYLim(1);

        oBeam.Time  = 104;
        stBeam      = oBeam.Density;
        aProj2      = abs(sum(stBeam.Data));
        aProj2      = 0.30*(aYLim(2)-aYLim(1))*aProj2/max(abs(aProj2))+aYLim(1);
        
        oFLD        = EField(oData,'e1','Units','SI','X1Scale','mm');
        oFLD.X1Lim  = aXLim;

        oFLD.Time   = 20;
        stData      = oFLD.Lineout(3,3);
        aData1      = stData.Data;

        oFLD.Time   = 104;
        stData      = oFLD.Lineout(3,3);
        aData2      = stData.Data;

        aXAxis      = stData.X1Axis;

        hold on;
        plot(aXAxis,aProj1,     'Color',[0.7 0.7 1.0],'LineWidth',1);
        plot(aXAxis,aProj2,     'Color',[0.0 0.0 1.0],'LineWidth',1);
        plot(aXAxis,aData1*1e-6,'Color',[0.7 0.9 0.6],'LineWidth',1);
        plot(aXAxis,aData2*1e-6,'Color',[0.2 0.6 0.0],'LineWidth',1);
        hold off;
        
        [h,i] = legend(sLegend,'Location','NE');
        set(h,'Box','Off');
        set(i(:),'LineStyle','None');
        
        title('');
        xlim(aXLim);
        ylim(aYLim);
        
        xlabel('\xi [mm]');
        ylabel('E_z [MeV]');

        if p~=4
            xlabel('');
            set(axM,'XTickLabel',[]);
        end % if
    end % for
    
end

% End