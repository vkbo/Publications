
%
% Plot: Plasma Density Simulations X
%

function pubNAPAC16XPlasmaDensity()

    oData = OsirisData('Silent','Yes');
    
    figure(34);
    clf;
    fFigureSize(gcf,[500 375]);

    ax1 = axes('Units','Pixels','Position',[52 45 445 325]);
    oData.Path = 'PPE-X07A';
    fPlotPlasmaDensity(oData,30,'PE', ...
        'IsSubPlot','Yes','AutoResize','Off','HideDump','Yes','Absolute','Yes', ...
        'Scatter1','PB','Scatter2','EB', ...
        'Sample1',500,'Sample2',500, ...
        'Overlay1','PB','Overlay2','EB', ...
        'Filter1','WRandom','Filter2','WRandom', ...
        'E1',[3 3],'W2',[3 3], ...
        'Limits',[0 3 -0.6 0.6]);
    title('');

end % function

