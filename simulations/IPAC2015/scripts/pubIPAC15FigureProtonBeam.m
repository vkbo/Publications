
%
%  Proton Beam Figure
% ********************
%  For IPAC'15 Paper
%

function stReturn = pubIPAC15FigureProtonBeam(sMode)

    stReturn = {};

    figMain = figure(20); clf;
    set(figMain,'InvertHardCopy','Off');

    switch(lower(sMode))
        case 'paper'
            fFigureSize(figMain,[500 450]);
            set(figMain,'Color',[1.0 1.0 1.0]);
            aM = get(figMain,'Position');

            % Calculate Axes
            aX1 = [62 0 aM(3)-72 (aM(4)-105)*0.60];
            aX2 = [62 0 aM(3)-72 (aM(4)-105)*0.40];
            aX2(2) = 45;
            aX1(2) = aX2(4)+100;

        case 'poster'
            fFigureSize(figMain,[900 700]);
            set(figMain,'Color',[1.0 1.0 0.894]);
            aM = get(figMain,'Position');

            % Calculate Axes
            aX1 = [62 0 aM(3)-72 (aM(4)-105)*0.60];
            aX2 = [62 0 aM(3)-72 (aM(4)-105)*0.40];
            aX2(2) = 45;
            aX1(2) = aX2(4)+100;

        case 'presentation'
            fFigureSize(figMain,[900 700]);
            set(figMain,'Color',[1.0 1.0 0.894]);
            aM = get(figMain,'Position');

            % Calculate Axes
            aX1 = [62 0 aM(3)-72 (aM(4)-105)*0.60];
            aX2 = [62 0 aM(3)-72 (aM(4)-105)*0.40];
            aX2(2) = 45;
            aX1(2) = aX2(4)+100;
            
    end % dwitch
    
    % Top figure
    %axTop = axes('Units','Pixels','Position',[50 aMPos(2)*0.4 aMPos(3)-100 aMPos(4)*0.5]);
    axTop = axes('Units','Pixels','Position',aX1);

    oData1 = OsirisData('Silent','Yes');
    oData1.Path = 'PPE-U01A';
    oData2 = OsirisData('Silent','Yes');
    oData2.Path = 'PPE-U01B';

    stReturn.Top = fPlotBeamFourier(oData1,104,'PB','IsSubPlot','Yes','HideDump','Yes', ...
                                    'Legend','Pre-modulated', ...
                                    'RefLegend','Self-modulated', ...
                                    'RefData',oData2, ...
                                    'RefBeam','PB', ...
                                    'RefTime',104, ...
                                    'Limits',[0.7 1.3 0 0.6]);
    line([1 1], [0 0.6], 'Color', [0.0 0.6 0.0], 'LineStyle', '--');
    title('');
    
    % Bottom Figure
    axBtm = axes('Units','Pixels','Position',aX2);
    
    oData = OsirisData('Silent','Yes');
    oData.Path = 'PPE-U07D';

    % Proton Beam
    oCH       = Charge(oData,'PB','Units','SI','X1Scale','mm','X2Scale','mm');
    oCH.X1Lim = [12.6 13.0];
    oCH.X2Lim = [-1 1];
    stData    = oCH.Tracking('PStart','PEnd','Sample',1,'Filter','Top','Weights','Charge');
    
    stTags = fieldnames(stData.Data);
    iTags  = length(stTags);
    
    stPlot = struct();
    for t=1:iTags
        iCount = length(stData.TAxis);
        stPlot.(stTags{t}).Time = [];
        stPlot.(stTags{t}).Data = [];
        for i=1:iCount
            if stData.Data.(stTags{t})(i,12)
                stPlot.(stTags{t}).Time(end+1) = stData.TAxis(i);
                stPlot.(stTags{t}).Data(end+1) = stData.Data.(stTags{t})(i,1);
            end % if
        end % for
    end % for
    
    stReturn.PlotPB = stPlot;
    
    aTimePB = stPlot.(stTags{1}).Time;
    aDataPB = stPlot.(stTags{1}).Data;
    aDataPB = aDataPB-aDataPB(1);

    % Electron Beam
    oCH       = Charge(oData,'EB','Units','SI','X1Scale','mm','X2Scale','mm');
    oCH.X1Lim = [10.0 14.0];
    oCH.X2Lim = [-0.2 0.2];
    stData    = oCH.Tracking('PStart','PEnd','Sample',1,'Filter','Top','Weights','Charge');
    
    stTags = fieldnames(stData.Data);
    iTags  = length(stTags);
    
    stPlot = struct();
    for t=1:iTags
        iCount = length(stData.TAxis);
        stPlot.(stTags{t}).Time = [];
        stPlot.(stTags{t}).Data = [];
        for i=1:iCount
            if stData.Data.(stTags{t})(i,12)
                stPlot.(stTags{t}).Time(end+1) = stData.TAxis(i);
                stPlot.(stTags{t}).Data(end+1) = stData.Data.(stTags{t})(i,1);
            end % if
        end % for
    end % for
    
    stReturn.PlotEB = stPlot;
    
    aTimeEB = stPlot.(stTags{1}).Time;
    aDataEB = stPlot.(stTags{1}).Data;
    aDataEB = aDataEB-aDataEB(1);

    % Ez Field
    oFLD = EField(oData,'e1','Units','SI','X1Scale','mm');
    oFLD.X1Lim = [10.9 12.5];

    aDataEZ = zeros(1,96);
    aTimeEZ = zeros(1,96);
    fprintf('Tracking: %5.1f%%',0);
    for t=10:105
        oFLD.Time = t;
        stData = oFLD.Lineout(3,3);
        [~,iMin] = min(stData.Data);
        aDataEZ(t-9) = stData.X1Axis(iMin);
        aTimeEZ(t-9) = stData.ZPos;
        fprintf('\b\b\b\b\b\b%5.1f%%',100.0*(t-10)/(95));
    end % for
    fprintf('\n');
    aDataEZ = aDataEZ-aDataEZ(1);
    stReturn.PlotEZ.Time = aTimeEZ;
    stReturn.PlotEZ.Data = aDataEZ;

    % Bottom Plot
    hold on;
    plot(aTimeEB,aDataEB*1e3,'Color','Blue','LineWidth',2);
    plot(aTimePB,aDataPB*1e3,'Color','Red','LineWidth',2);
    %plot(aTimeEZ,aDataEZ*1e3,'Color','Green','LineWidth',2);
    hold off;
    
    title('');
    xlabel('z [m]');
    ylabel('\xi - \xi_0 [µm]');
    legend({'Electron track','Proton track'},'Location','NE');
    
    xlim([0 10]);
    ylim([-45 5]);
    
end

% End