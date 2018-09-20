
%
% Plot: Energy Spread
%

function pubNAPAC16EnergyGain()

    oData  = OsirisData('Silent','Yes');
    iStart = 10;
    iEnd   = 38;
    
    figure(36);
    clf;
    fFigureSize(gcf,[600 245]);
    oData.Path = 'PPE-U28J';

    ax1 = axes('Units','Pixels','Position',[55 44 239 200]);
    
    oMom  = Momentum(oData,'EB','Units','SI');
    stMom = oMom.SigmaEToEMean(iStart,iEnd);
    aMomM = (stMom.Mean-stMom.Mean(1))*1e-6;
    aMomS = stMom.Sigma*1e-6;
    aAxis = stMom.TAxis;

    shadedErrorBar(aAxis,aMomM,aMomS,{'Color',[0.0 0.0 1.0],'LineWidth',1});
    ylim([0 340]);
    xlim([aAxis(1),aAxis(end)]);
    xlabel('z [m]','FontSize',10);
    ylabel('\langleP_z - P_{z,0}\rangle [MeV/c]','FontSize',10);
    title('');

    ax2 = axes('Units','Pixels','Position',[360 44 239 200]);
    oPha = Phase(oData,'EB','Units','SI');

    aRMS = zeros(50,1);
    aQty = zeros(50,1);
    aDist = zeros(50,424);
    for t=iStart:iEnd
        oPha.Time  = t;
        stPha      = oPha.RawHist1D('x2','Grid',424);
        aRMS(t)    = stPha.Std*1e6;
        aDist(t,:) = stPha.Data;
        aQty(t)    = 100*sum(stPha.Data(211:214))/sum(stPha.Data);
    end % for
    
    stPha.Axis(211:214)
    
    hold on;
    stairs(aAxis,aRMS(iStart:iEnd),'Color',[0.0 0.0 1.0]);
    stairs(aAxis,aQty(iStart:iEnd),'Color',[1.0 0.0 0.1]);
    hold off;
    
    %imagesc(aAxis,stPha.Axis(300:500)*1e6,aDist(10:iEnd,300:500)');
    %set(gca,'YDir','Normal');
    %colormap('hot');
    %caxis([0.001 0.015]);

    xlim([aAxis(1),aAxis(end)]);
    ylim([0 105]);
    xlabel('z [m]','FontSize',10);
    ylabel('\color{blue} R_{RMS} [µm] \color{black} | \color{red} r \leq 20 µm [%]','FontSize',10);
    title('');
    set(gca,'Box','On');
    
end % function

