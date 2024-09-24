# Transduction Efficiency Analysis Macro

## Overview
This repository contains an ImageJ macro script designed for analyzing transgene expression in cell cultures following viral transduction. The macro quantifies the percentage of fluorescent (transduced) cells versus non-fluorescent cells, aiding in determining viral titre and transduction efficiency.

## Background
The macro is described in detail in Appendix A.4.I and Methods Section 3.7.iii of my thesis, titled "Titre and Quantification of Transduction Efficiency."

## Experimental Procedure
Cells were analyzed for transgene expression 96 hours post-transduction. Images were acquired using:
- **Microscopes**: Nikon Inverted Microscope Eclipse Ti-S at 10x magnification or Cytation™ 5 - Cell Imaging Multi-Mode Reader at 4x magnification.
- **Image Acquisition**: At least 10 images per well on the Nikon microscope or 16 images per well using the Cytation™ 5 reader, both fluorescent and transmitted light.

The macro was used to convert transmitted light and fluorescence images from the same XY position to binary masks, allowing accurate identification of fluorescent and non-fluorescent cells.

## Calculation of Transduction Efficiency
The macro calculates transduction efficiency using the following formula:

\[
\% \text{Transduced} = \sum \left( \frac{\text{GFP positive pixels}}{\text{GFP positive pixels} + \text{total pixels within all cell regions}} \right) \div (0.01 \times n)
\]

Where `n` is the number of images taken per well.

## Calibration
The results were calibrated against flow cytometry analysis using a 1.5 x 10^5 cell sample from each well.

## Viral Titre Calculation
The viral titre was determined using the equation:

\[
\text{Infectious particles/µl} = \frac{(2.5 \times 10^5 \times \% \text{Transduced})}{x}
\]

Where `x` is the volume of lentiviral suspension applied in µl.

## How to Use the Macro
1. Install [ImageJ](https://imagej.nih.gov/ij/download.html) if you haven’t already.
2. Open the macro script (`TransductionEfficiencyMacro.ijm`) in ImageJ.
3. Follow the prompts to analyze your .tif files in a chosen directory.

## License
This project is licensed under the [Apache License 2.0](./LICENSE) - see the LICENSE file for details.
