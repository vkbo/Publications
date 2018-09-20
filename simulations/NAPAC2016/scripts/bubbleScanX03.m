%
%  Simulation Series X03
% ***********************
%  Plasma Bubble Scan
%

function stReturn = bubbleScanX03()

    iLoop = 26;

    stReturn = {};
    
    cSims = {'X03A','X03B','X03C','X03D','X03E','X03F', ...
             'X03G','X03H','X03I','X03J','X03K','X03L', ...
             'X03M','X03N','X03O','X03P','X03Q','X03R', ...
             'X03S','X03T','X03U','X03V','X03W','X03X', ...
             'X03Y','X03Z'};
    
    cFits = {'gauss1'};

    %cFits = {'gauss1','gauss2','gauss3','gauss4','gauss5','gauss6','gauss7','gauss8', ...
    %         'sin1','sin2','sin3','sin4','sin5','sin6','sin7','sin8'};
    
    aQ  = zeros(1,26);
    aEz = zeros(1,26);
    aDn = zeros(1,26);
    
    oData = OsirisData;
    
    for s=1:iLoop
        
        oData.Path = ['PPE-' cSims{s}];
    
        oFLD = Field(oData,'e1','Units','SI','Scale','mm');
        oFLD.Time = 40;

        fprintf('\n');
        fprintf(' Simulation: %s\n',oData.Config.Name);
        fprintf('======================\n');

        stLnEz = oFLD.Lineout(3,3);
        aLine  = stLnEz.Data(84:207);
        dMaxEz = -min(aLine)*1e-6;
        aEz(s) = dMaxEz;
        fprintf(' Max Accelerating Field: %9.3f MV/m\n',dMaxEz);
        
        oDN = Density(oData,'PB','Units','SI','Scale','mm');
        oDN.Time = 40;

        stQ   = oDN.BeamCharge;
        dQ    = stQ.QTotal*1e9;
        aQ(s) = dQ;
        fprintf(' Total Beam Charge:      %9.3f nC\n',dQ);

        oDN = Density(oData,'PE','Units','SI','Scale','mm');
        oDN.Time = 40;

        stQ    = oDN.Density2D;
        aProjQ = sum(stQ.Data, 1);

        [~,dMax] = max(aProjQ(100:223));
        aSlice  = double(mean(stQ.Data(51:750,[dMax-3 dMax+3]+99),2))+1;
        aSmooth = -smooth(stQ.Data(:,dMax+99),11,'rlowess');
        aSmooth = [ones(1,5) aSmooth(56:745)' ones(1,5)];
        %size(aSmooth)
        aXAxis  = double(stQ.VAxis(51:750));

        aFits  = zeros(1,numel(cFits));
        for f=1:numel(cFits)
            [oFit, oGOF] = fit(aXAxis',aSlice,cFits{f});
            aFits(f) = oGOF.rmse;
            [~,iLeast] = min(aFits);
        end % for
        [oFit, oGOF] = fit(aXAxis',aSlice,cFits{iLeast});
        aFit = 1-feval(oFit,aXAxis);
        aSlice = 1-aSlice;
        
        aSigma  = [];
        dMinDen = min(aFit);
        aDn(s)  = dMinDen;
        fprintf(' Min Plasma Density:     %9.3f %%\n',dMinDen*100);
        if iLeast <= 8
            fprintf(' RMS Error for %s:   %9.3f\n',cFits{iLeast},aFits(iLeast));
            aSigma = zeros(1,iLeast);
            for i=1:iLeast
                aSigma(i) = oFit.(sprintf('c%d',i))/sqrt(2);
            end % for
        else
            fprintf(' RMS Error for %s:     %9.3f\n',cFits{iLeast},aFits(iLeast));
        end % if

        dLen    = length(aSlice);
        dRes    = 2.0;
        aIAxis  = linspace(aXAxis(1),aXAxis(dLen/2),dRes*dLen/2);
        aSpline = interp1(aXAxis(1:dLen/2),aSlice(1:dLen/2),aIAxis,'spline');
        aSpline = [aSpline fliplr(aSpline)];
        aIAxis  = linspace(aXAxis(1),aXAxis(end),dRes*dLen);
        
        aFFT = fft(aSlice);
        aP2  = abs(aFFT/dLen);
        aP1  = aP2(1:dLen/2+1);
        aP1(2:end-1) = 2*aP1(2:end-1);
        
        min(aFFT)
        max(aFFT)
        
        aFFT(aFFT < 1.5) = 0;
        
        aIFFT = real(ifft(aFFT,dLen));

        figure(29);
        clf;
        hold on;
        plot(aP1);
        hold off;

        figure(30);
        clf;
        hold on;
        plot(aXAxis, aSlice);
        plot(aXAxis, aFit);
        %plot(aXAxis, aIFFT);
        plot(aXAxis, aSmooth);
        %plot(aIAxis, aSpline);
        hold off;

        fprintf('\n');

        stReturn.(cSims{s}).MaxEz   = dMaxEz;
        stReturn.(cSims{s}).Charge  = dQ;
        stReturn.(cSims{s}).MinDen  = dMinDen;
        stReturn.(cSims{s}).Axis    = aXAxis;
        stReturn.(cSims{s}).Data    = aSlice;
        stReturn.(cSims{s}).Fit     = aFit;
        stReturn.(cSims{s}).FitType = cFits{iLeast};
        stReturn.(cSims{s}).Sigma   = aSigma;
        stReturn.(cSims{s}).RMSErr  = aFits(iLeast);
        stReturn.(cSims{s}).FFT     = aFFT;
        
    end % for

    figure(31);
    clf;
    hold on;
    for s=1:iLoop
        %plot(stReturn.(cSims{s}).Axis, stReturn.(cSims{s}).Data);
        plot(stReturn.(cSims{s}).Axis, stReturn.(cSims{s}).Fit);
    end % for
    hold off;
    
    xlim([-1000 1000]*oData.Config.Simulation.PhysLambdaP);
    xlabel('r [mm]');
    ylabel('n/n_0');
    title('Plasma Electron Density for Q_{PB} = 0.5 -> 13 nC');

    figure(32);
    clf;
    plot(aQ, aEz);
    xlabel('Charge [nC]');
    ylabel('e_z [MV/m]');
    title('Max e_z as a Function of Q_{PB}');

    figure(33);
    clf;
    plot(aEz, aDn);
    xlabel('e_z [MV/m]');
    ylabel('Min Density [n/n_0]');
    title('Plasma Electron Density as a Function of Max e_z');

end

