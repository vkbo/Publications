
%
% Plot: Energy Spread
%

function pubNAPAC16EnergySpread()

    oData = OsirisData('Silent','Yes');
    
    figure(31);
    clf;
    fFigureSize(gcf,[500 260]);

    %ax1 = axes('Units','Pixels','Position',[50 250 400 200]);
    %oData.Path = 'PPE-U28C';
    %fPlotRaw1D(oData,16,'EB','p1','GaussFit','Yes','Lim',[240 310]*1e6,'Grid',300,'IsSubPlot','Yes');
    %title('');

    ax2 = axes('Units','Pixels','Position',[36 48 463 210]);
    oData.Path = 'PPE-U28J';
    stReturn = fPlotRaw1D(oData,30,'EB','p1','GaussFit','Yes','FitRange',[440 500],'Lim',[420 466]*1e6,'Grid',100,'IsSubPlot','Yes','HideDump','Yes');
    title('');
    
    iCut = fGetIndex(stReturn.HAxis,440);
    
    dX = stReturn.HAxis(iCut)+(stReturn.HAxis(iCut+1)-stReturn.HAxis(iCut))/2;
    line([dX dX],ylim,'Color',[0.6 0.6 0.6],'LineStyle','--');
    
    dTot  = sum(stReturn.Data);
    dLow  = sum(stReturn.Data(1:iCut));
    dHigh = sum(stReturn.Data(iCut+1:end));
    
    fprintf('RSquare = %.3f\n',stReturn.Goodness.rsquare);
    fprintf('Low     = %.1f\n',100*dLow/dTot);
    fprintf('High    = %.1f\n',100*dHigh/dTot);

end % function

