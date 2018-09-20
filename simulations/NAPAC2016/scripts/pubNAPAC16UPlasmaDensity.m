
%
% Plot: Plasma Density Simulations U
%

function pubNAPAC16UPlasmaDensity()

    oData = OsirisData('Silent','Yes');
    
    figure(32);
    clf;
    fFigureSize(gcf,[500 375]);

    ax1 = axes('Units','Pixels','Position',[52 45 445 325]);
    oData.Path = 'PPE-U28J';
    fPlotPlasmaDensity(oData,30,'PE', ...
        'IsSubPlot','Yes','AutoResize','Off','HideDump','Yes','Absolute','Yes', ...
        'Scatter1','PB','Scatter2','EB', ...
        'Sample1',2000,'Sample2',500, ...
        'Overlay1','PB','Overlay2','EB', ...
        'Filter1','WRandom','Filter2','WRandom', ...
        'E1',[3 3],'W2',[3 3], ...
        'Limits',[10 13.5 -0.4 0.4]);
    title('');

end % function

