
%
% Plot ParameterScan Function for Simulations U16x–U20x
% 

function pubNAPAC16ParamScan()

    load('ParameterScanU28.mat')
    stData = stResultU28;

    aIndex(1:6) = [1 5 9 13 17 21];
    aMin        = ones(1,6)*1000;
    cLegend     = {};
    
    figure(30);
    clf;
    fFigureSize(gcf,[500 320]);
    axMain = axes('Units','Pixels','Position',[62 3 437 315],'Box','On');
    hold on;
    
    for j=1:4
        dMin = 1000;
        for i=1:6
            aC(i) = stData(aIndex(i)).Current;
            aH(i) = i+0.2*j-0.5;
            aV(i) = stData(aIndex(i)+j-1).PGain;
            aS(i) = stData(aIndex(i)+j-1).PSigma;
            
            dSigma = stData(aIndex(i)+j-1).Sigma;
            
            if aMin(i) > aV(i)-aS(i)
                aMin(i) = aV(i)-aS(i);
            end % if
        end % for

        errorbar(aH,aV,aS,'o');
        cLegend{j} = sprintf('σ_z = %.0f µm',dSigma);
        
    end % for
    
    for c=1:6
        line([c-0.45 c+0.45],[1 1]*(aMin(c)-10),  'Color',[0.0 0.0 0.0]);
        line([c-0.45 c-0.45],[aMin(c)-10 aMin(c)],'Color',[0.0 0.0 0.0]);
        line([c+0.45 c+0.45],[aMin(c)-10 aMin(c)],'Color',[0.0 0.0 0.0]);
        %text(c, aMin(c)-24,sprintf('I_{EB} = %.0f A',aC(c)),'HorizontalAlignment','Center');
        text(c, aMin(c)-24,sprintf('%.0f A',aC(c)),'HorizontalAlignment','Center');
    end % for

    line([0.4 6.6],[0 0],'Color',[0.5 0.5 0.5],'LineStyle','--')

    hold off;
    
    xlim([0.4 6.6]);
    ylim([-175 305]);
    set(gca,'XTick',[]);
    
    legend(cLegend,'Location','SW');
    
    ylabel('\langleP_z - P_{z,0}\rangle [MeV/c]');
    title('');

end % function
