lightCam
=========
A light curve visualizer.

Description
===========
This application serves as an educational tool to visualize light curves and demonstrate the formation of planetary transits. You can run the platform-specific applications provided in the `application.*` folders. You'll need the latest version of Java 7 and a webcam. If you want to make changes to the code, download and install the Processing programming environment (https://processing.org/download/) and open the `lightCam.pde` file. Enjoy!

How it works
============
The lightCam app uses your webcam to create a "light curve" by taking a picture every fraction of a second and plotting its average brightness. The higher the point appears in the plot, the brighter the frame and vice versa. Note that most webcams recalibrate after sudden changes in brightness which results in a sudden peak in the plot which is not found in real light curves. Otherwise, each frame represents a single observation, or data point, not unlike the light curves generated from NASA's Kepler telescope.
