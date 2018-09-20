# Publications

This repository contains a list of papers and proceedings listed on my website [vkbo.net](http://vkbo.net) together with scripts and simulation input files where this is relevant.

## Simulation Information

Following are the simulation input files, scripts and some of the figures used for the listed publications. The files are in the simulations folder with the subfolder corresponding to the heading.

### Physical Review 2018

**Emittance preservation of an electron beam in a loaded quasilinear plasma wakefield**<br>
*Physical Review Accelerators and Beams (2018)*

Published PDF: [PRAB 21 011301](https://journals.aps.org/prab/pdf/10.1103/PhysRevAccelBeams.21.011301)<br>
Source Files: [simulations/PRAB2018](simulations/PRAB2018)<br>
Simulation Software: [QuickPIC](https://plasmasim.physics.ucla.edu/codes/quickpic)<br>
Analysis Software: MATLAB

* Figure 2
  * Script: `bl17PlasmaDensityTWake.m`
  * Input: `PPE-Q13A`, `PPE-Q14B`
* Figure 3
  * Script: `bl17BeamLoading.m`
  * Input: `PPE-Q13A`, `PPE-Q14B`, `PPE-Q14C`
* Figure 4
  * Script: `bl17PhaseSpace.m`
  * Input: `PPE-Q13A`
* Figure 5, Left
  * Script: `bl17SliceEmittance.m`
  * Input: `PPE-Q13C`
* Figure 5, Right
  * Script: `bl17SliceEmittanceOffset.m`
  * Input: `PPE-Q13D`
* Figure 6
  * Script: `bl17TPhaseSpaceStillsPos.m`
  * Input: `PPE-Q14A`
* Figure 7 and 8
  * Script: `bl17ParamScan.m`
  * Input: `PPE-Q07[ABCDE]`, `PPE-Q09[ABCDE]`, `PPE-Q10[ABCDE]`, `PPE-Q11[ABCDE]`, `PPE-Q17[CEGINOPQRSTUVWXY]`, `PPE-Q18[ABCDEFGHIJKLMNOP]`
* Figure 9
  * Script: `bl17ParamScanEmitt.m`
  * Input: `PPE-Q19[ABCDEFGHIJKLMNOPQRSTUVWX]`
* Figure 10
  * Script: `bl17ParamScanOffset.m`
  * Input: `PPE-Q07A`, `PPE-Q20[ABCD]`, `PPE-Q21[ABCDEFGHIJKLMNOP]`
* Resolution Scans
  * Input: `PPE-Q22[ABCDEF]`, `PPE-Q23[ABCDEF]`


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
