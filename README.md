lightCam
=========
A light curve visualizer.

Description
===========
This application serves as an educational tool to visualize light curves and demonstrate the formation of planetary transits. To use it you must (1) have a webcam installed, (2) download and install the Processing programming environment (https://processing.org/download/) and (3) run the included `lightCam.pde` code. Enjoy!

How it works
============
The Processing sketch `lightCam.pde` uses your webcam to come up with an average brightness for each frame. The frames are blurred to remove unwanted noise and make the "light curve" more realistic. Each frame can represent a single observation (data point), analogous to how NASA's Kepler telescope generates its light curves. The default frame rate is set to 30fps and an additional variable, `interval`, can be used to set the rate at which the points are plotted. 
