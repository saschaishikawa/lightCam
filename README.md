lightCam
=========
A light curve visualizer.

Description
===========
This application serves as an educational tool to visualize light curves and demonstrate the formation of planetary transits. You can run the platform-specific applications provided in the `application.*` folders. You'll need the latest version of Java 7 and a webcam. If you want to make changes to the code, download and install the Processing programming environment (https://processing.org/download/) and open the `lightCam.pde` file. Enjoy!

How it works
============
The Processing sketch `lightCam.pde` uses your webcam to come up with an average brightness for each frame. The frames are blurred to remove unwanted noise and make the "light curve" more realistic. Note that most webcams recalibrate after sudden changes in brightness which results in a sudden peak in the plot which are not found in real light curves. Otherwise, each frame represents a single observation, or data point, analogous to how NASA's Kepler telescope generates its light curves.
