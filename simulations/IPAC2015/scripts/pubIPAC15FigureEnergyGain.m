
%
%  Energy Gain Figure
% ********************
%  For IPAC'15 Paper
%

function pubIPAC15FigureEnergyGain(sMode)

    stReturn = {};

    figMain = figure(20); clf;

    switch(lower(sMode))
        case 'paper'
            fFigureSize(figMain,[500 450]);
            set(figMain,'Color',[1.0 1.0 1.0]);
            set(figMain,'InvertHardCopy','Off');
            aM = get(figMain,'Position');

            % Calculate Axes
            aX1 = [62  0 aM(3)-72        (aM(4)-105)*0.60];
            aX3 = [62 45 (aM(3)-132)*0.5 (aM(4)-105)*0.40];
            aX4 = [62 45 (aM(3)-132)*0.5 (aM(4)-105)*0.40];
            aX4(1) = aX4(1)+aX3(3)+60;
            aX1(2) = aX3(4)+100;

        case 'poster'
            fFigureSize(figMain,[1200 550]);
            set(figMain,'Color',[1.0 1.0 0.894]);
            set(figMain,'InvertHardCopy','Off');
            aM = get(figMain,'Position');

            % Calculate Axes
            aX1 = [62 45 (aM(3)-150)*0.65 (aM(4)-80)];
            aX3 = [62 45 (aM(3)-150)*0.35 (aM(4)-150)*0.50];
            aX4 = [62 45 (aM(3)-150)*0.35 (aM(4)-150)*0.50];
            aX3(2) = aX4(4)+130;
            aX3(1) = aX1(3)+140;
            aX4(1) = aX1(3)+140;
            aX1(4) = aX3(4)+aX3(2)-aX1(2);

        case 'presentation'
            fFigureSize(figMain,[1100 600]);
            aM = get(figMain,'Position');

            % Calculate Axes
            aX1 = [62 45 (aM(3)-150)*0.65 (aM(4)-80)];
            aX3 = [62 45 (aM(3)-150)*0.35 (aM(4)-150)*0.50];
            aX4 = [62 45 (aM(3)-150)*0.35 (aM(4)-150)*0.50];
            aX3(2) = aX4(4)+130;
            aX3(1) = aX1(3)+140;
            aX4(1) = aX1(3)+140;
            aX1(4) = aX3(4)+aX3(2)-aX1(2);

    end % dwitch
    
    
    oData1 = OsirisData('Silent','Yes');
    oData1.Path = 'PPE-U10A';
    sTitle1 = 'No Gradient';

    oData2 = OsirisData('Silent','Yes');
    oData2.Path = 'PPE-U10B';
    sTitle2 = '3.5% Gradient';
    
    % Top Figure
    axTop = axes('Units','Pixels','Position',aX1);

    hold on;

    oM = Momentum(oData1, 'EB', 'Units', 'SI');
    stData = oM.SigmaEToEMean('PStart','PEnd');
    H(1) = shadedErrorBar(stData.TimeAxis, stData.Mean*1e-9, stData.Sigma*1e-9, {'-b', 'LineWidth', 2});
    
    fprintf('Blue Mean:       %7.2f MeV\n',stData.Mean(end)*1e-6);
    fprintf('Blue Sigma:      %7.2f MeV\n',stData.Sigma(end)*1e-6);
    fprintf('Blue Sigma/Mean: %7.2f %%\n',100*stData.Sigma(end)/stData.Mean(end));

    oM = Momentum(oData2, 'EB', 'Units', 'SI');
    stData = oM.SigmaEToEMean('PStart','PEnd');
    H(2) = shadedErrorBar(stData.TimeAxis, stData.Mean*1e-9, stData.Sigma*1e-9, {'-r', 'LineWidth', 2});

    fprintf('Red  Mean:       %7.2f MeV\n',stData.Mean(end)*1e-6);
    fprintf('Red  Sigma:      %7.2f MeV\n',stData.Sigma(end)*1e-6);
    fprintf('Red  Sigma/Mean: %7.2f %%\n',100*stData.Sigma(end)/stData.Mean(end));

    hold off;
    
    legend([H(1).mainLine, H(2).mainLine],sTitle1,sTitle2,'Location','NW');

    xlim([0 10]);
    ylim([0 1.8]);
    xlabel('z [m]');
    ylabel('p_{z} [GeV/c]');

    % Bottom Left Figure
    axBtmL = axes('Units','Pixels','Position',aX3);
    stReturn.Bottom = fPlotPhase2D(oData1,104,'EB','x1','p1', ...
                                   'IsSubPlot','Yes','HideDump','Yes', ...
                                   'HLim',[11.80e-3 12.10e-3],'VLim',[0.6e9 1.2e9]);
    title(sTitle1,'FontSize',10,'FontWeight','Normal');
    hL = legend('');
    set(hL,'Visible','Off');

    % Bottom Right Figure
    axBtmR = axes('Units','Pixels','Position',aX4);
    stReturn.Bottom = fPlotPhase2D(oData2,104,'EB','x1','p1', ...
                                   'IsSubPlot','Yes','HideDump','Yes', ...
                                   'HLim',[11.80e-3 12.10e-3],'VLim',[1.4e9 1.8e9]);
    title(sTitle2,'FontSize',10,'FontWeight','Normal');
    hL = legend('');
    set(hL,'Visible','Off');
    
    if strcmpi(sMode,'paper')
        ch = findall(gcf,'tag','Colorbar');
        delete(ch(1));
        delete(ch(2));
    end % if
    
end

% End