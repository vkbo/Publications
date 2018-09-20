
%
%  Plots Beam Cunfiguration
% **************************
%  For IPAC'15 Paper
%

function pubIPAC15FigureDensity(sMode)

    stReturn = {};

    figMain = figure(20); clf;
    set(figMain,'InvertHardCopy','Off');

    switch(lower(sMode))
        case 'paper'
            fFigureSize(figMain,[500 450]);
            set(figMain,'Color',[1.0 1.0 1.0]);
            aM = get(figMain,'Position');

            % Calculate Axes
            aX1 = [62 0 aM(3)-72 (aM(4)-95)*0.75];
            aX2 = [62 0 aM(3)-72 (aM(4)-95)*0.25];
            aX2(2) = 45;
            aX1(2) = aX2(4)+90;

        case 'poster'
            fFigureSize(figMain,[900 800]);
            set(figMain,'Color',[1.0 1.0 0.894]);
            aM = get(figMain,'Position');

            % Calculate Axes
            aX1 = [62 0 aM(3)-72 (aM(4)-120)*0.75];
            aX2 = [62 0 aM(3)-72 (aM(4)-120)*0.25];
            aX2(2) = 45;
            aX1(2) = aX2(4)+100;

        case 'presentation'
            fFigureSize(figMain,[900 800]);
            set(figMain,'Color',[1.0 1.0 0.894]);
            aM = get(figMain,'Position');

            % Calculate Axes
            aX1 = [62 0 aM(3)-72 (aM(4)-120)*0.75];
            aX2 = [62 0 aM(3)-72 (aM(4)-120)*0.25];
            aX2(2) = 45;
            aX1(2) = aX2(4)+100;

    end % dwitch
    
    % Top figure
    %axTop = axes('Units','Pixels','Position',[50 aMPos(2)*0.4 aMPos(3)-100 aMPos(4)*0.5]);
    axTop = axes('Units','Pixels','Position',aX1);

    oData = OsirisData('Silent','Yes');
    oData.Path = 'PPE-U10A';

    stReturn.Top = fPlotPlasmaDensity(oData,104,'PE','IsSubPlot','Yes','HideDump','Yes', ...
                                      'Limits',[10 14 -0.15 0.15],'CAxis',[0 5], ...
                                      'Overlay1','PB','Overlay2','EB', ...
                                      'Scatter1','PB','Scatter2','EB', ...
                                      'Sample1',2000,'Sample2',1000, ...
                                      'Filter1','W2Random','Filter2','W2Random', ...
                                      'E1',[3,3],'E2',[3,3]);
    if strcmpi(sMode,'paper')
        title('');
    else
    end % if
    
    % Bottom Figure
    axBtm = axes('Units','Pixels','Position',aX2);
    
    oData = OsirisData('Silent','Yes');
    oData.Path = 'PPE-U05B';
    
    stReturn.Bottom = fPlotBeamDensity(oData,0,'PB','IsSubPlot','Yes','HideDump','Yes', ...
                                       'ShowOverlay','No','Limits',[4.4 38.2 -0.7 0.7]);
    freezeColors;
    title('');

    if strcmpi(sMode,'paper')
        ch = findall(gcf,'tag','Colorbar');
        delete(ch(1));
        delete(ch(2));
    else
        ch = findall(gcf,'tag','Colorbar');
        delete(ch(1));
        aPos1 = get(axTop,'Position');
        aPos2 = get(axBtm,'Position');
        aPos2(3) = aPos1(3);
        set(axBtm,'Position',aPos2);
    end % if

    colormap('gray');
    
    
end

% End