01 Sep 2010, Arman
-------------------
Rapid2 Matlab toolbox for controlling Magstim Rapid^2 stimulator via a serial connection. 


Installation Instructions
-------------------------
1. Copy the toolbox files into a directory called Rapid2
2. Add Rapid2 directory to the Matlab path


Usage Instructions
------------------
1. You will need a serial cable connection between the Rapid^2 stimulator and PC. 
2. Details for preparing a serial cable and description of Rapid2 toolbox will soon be published in a companion publication which will be distributed under 'open access' for anyone to download.


How to test the toolbox
-----------------------
If you have a serial cable, the toolbox can be tested by downloading an example script from here: http://www.psych.usyd.edu.au/tmslab/rapid2andrept.html
1. Ensure Rapid2 toolbox is in your Matlab path
2. Run ControllingStimulatorExample.m
3. Important: Press '1' on keyboard to arm the stimulator. You should now hear a click from the stimulator which indicates that the stimulator has been put into 'online' mode. Without arming the stimulator you wouldn't be able to trigger a pulse.
4. Press 'Spacebar' to trigger a pulse. 
5. Press left or right 'Shift' keys to increase or decrease power levels. 
6. To disarm the stimulator, press '0'


Software and System Requirements
-------------------
1. The toolbox was developed and tested under Windows XP and Windows 7. Mac OS X can also be used provided you have a "USB to serial" adapter.  
2. Matlab version: 7.7 (R2008b) or above. It might work with older versions but I haven't had chance to test. 
3. Computer: Fast processor speed starting from 2GHz and at least 1.5Gb of RAM.   


Contact
-------
For questions, suggestions and bug reports please email Arman on: arman.abrahamyan@sydney.edu.au. 


License
-------
The toolbox is distributed under GNU General License and details are provided in License.txt file. 


Download
--------
The latest version of the toolbox can be downloaded from: http://www.psych.usyd.edu.au/tmslab/rapid2andrept.html 


DISCLAIMER 
----------
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>. 