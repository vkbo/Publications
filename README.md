# Publications

This repository contains a list of papers and proceedings listed on my website [vkbo.net](http://vkbo.net) together with scripts and simulation input files where this is relevant.

## Simulation Information

Following are the simulation input files, scripts and some of the figures used for the listed publications. The files are in the simulations folder with the subfolder corresponding to the heading.

### Proceedings of NAPAC2016

**Loading of Wakefields in a Plasma Accelerator Section Driven by a Self-Modulated Proton Beam**<br>
*Proceedings of NAPAC16, Chicago, IL, USA (2016)*

Published PDF: [NAPAC 2016 TUA4CO03](http://accelconf.web.cern.ch/AccelConf/napac2016/papers/tua4co03.pdf)<br>
Source Files: [simulations/NAPAC2016](simulations/NAPAC2016)<br>
Simulation Software: [OSIRIS 3.x](https://plasmasim.physics.ucla.edu/codes/osiris)<br>
Analysis Software: MATLAB

* Figure 1
  * Script: `pubNAPAC16ParamScan.m`
  * Data: `ParameterScanU28.mat`
  * Input: `PPE-U28A` to `PPE-U28X`
* Figure 2
  * Script: `pubNAPAC16UPlasmaDensity.m`
  * Input: `PPE-U28J`
* Figure 3
  * Script: `pubNAPAC16EnergySpread.m`
  * Input: `PPE-U28J`
* Figure 4
  * Script: `pubNAPAC16EnergyGain.m`
  * Input: `PPE-U28J`
* Figure 5
  * Script: `pubNAPAC16XPlasmaDensity.m`
  * Input: `PPE-X07A`

### Proceedings of IPAC2015

**Loading of a Plasma-Wakefield Accelerator Section Driven by a Self-Modulated Proton Bunch**<br>
*Proceedings of IPAC2015, Richmond, Virginia, USA (2015)*

Published PDF: [IPAC 2015 WEPWA026](https://jacowfs.jlab.org/conf/proceedings/IPAC2015/papers/wepwa026.pdf)<br>
Source Files: [simulations/IPAC2015](simulations/IPAC2015)<br>
Simulation Software: [OSIRIS 3.x](https://plasmasim.physics.ucla.edu/codes/osiris)<br>
Analysis Software: MATLAB

* Figure 2
  * Script: `pubIPAC15FigureDensity.m`
  * Input: `PPE-U10A` (top), `PPE-U05B` (bottom)
* Figure 3
  * Script: `pubIPAC15FigureProtonBeam.m`
  * Input: `PPE-U01A`, `PPE-U01B` (top), `PPE-U07D` (bottom)
* Figure 4  * Script: `pubIPAC15FigureEFields.m`
  * Input: `PPE-U03B`, `PPE-U03C`, `PPE-U03D`, `PPE-U03E` (in order)
* Figure 5
  * Script: `pubIPAC15FigureEnergyGain.m`
  * Input: `PPE-U10A` (no gradient), `PPE-U10B` (gradient)
