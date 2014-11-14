lightCam
=========
A light curve visualizer.

Description
===========
This application serves as an educational tool to visualize light curves and demonstrate the formation of planetary transits. You can run the platform-specific applications provided in the `application.*` folders. You'll need the latest version of Java 7 and a webcam. If you want to make changes to the code, download and install the Processing programming environment (https://processing.org/download/) and open the `lightCam.pde` file. Enjoy!

What is a light curve?
======================
A light curve is a time series of brightness measurements which can be used to hunt for planets around distant stars. Transits occur when a planet passes in front of its host star as viewed from the Earth. A portion of the star's light is blocked out, and the brightness observed decreases. For more information, check out http://www.planethunters.org/#/science

How lightCam works
==================
`lightCam` uses your webcam to create a "light curve" by taking a picture every fraction of a second and plotting its average brightness. The higher the point appears in the plot, the brighter the frame and vice versa. Like the light curves generated from NASA's Kepler telescope, each frame is a single observation, or data point, and tells you how bright the scene was at a given moment. 

A few usage notes
=================
Since `lightCam` measures the brightness of all light entering the webcam it can also be sensitive to reflective materials, or even a light-colored object. This may produce unrealistic light curves. For example, passing a white ball within the frame of the webcam may produce a spike (instead of a dip) in the light curve. For best results, use a bright and diffuse source of light as the "Sun" for backlighting. A paper lantern works great and helps counteract stray sources of light from reflective materials. This will make any object passing between the lamp and the webcam more shadowy and thus seem more like a transiting planet.

Note that most webcams recalibrate after sudden changes in brightness which results in a sudden peak in the plot which is not found in real light curves.
