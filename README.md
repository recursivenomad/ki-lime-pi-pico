**A comprehensive KiCad Library for the Raspberry Pi Pico** 🥧
==============================================================

### Providing footprints, symbols, and models for the module in its various forms and implementations

&nbsp;


![Image of all available Raspberry Pi Pico footprint variations](./_md-assets/images/footprints.png "Raspberry Pi Pico KiCad footprint variations")  
*The offered footprints of the Raspberry Pi Pico; all footprints also have a variant with mounting holes.*

![Image of all available Raspberry Pi Pico schematic variations](./_md-assets/images/schematics.png "Raspberry Pi Pico KiCad schematic variations")  
*The offered schematics of the Raspberry Pi Pico; many pins provide alternate pin definitions.*

![GIF of all available Raspberry Pi Pico 3D model variations](./_md-assets/images/models.gif "Raspberry Pi Pico 3D model variations")  
*The models feature the original Pico, Pico H, Pico W, and Pico WH; they are able to be visualised in surface-mount, through-hole, and socketed forms.*

&nbsp;



***Features***
==============

- **KiCad 7.0 support**
- **Schematics with alternate pin definitions** to select more specific behaviours for each GPIO, as well as specify power directionality
- **Generic and specific footprints** for the Pico and Pico W
  - Through-hole and surface-mount footprints with and without mounting holes
  - Hand-solderable test points (ie. USB signals) in footprints with underside castellations
  - Optional pin labels as an add-on footprint
  - Optional keepout zone for 2.4 GHz RF on shared footprints
- **Diverse 3D models** for surface-mount, through-hole, and socketed forms of the Pico, Pico H, Pico W, and Pico WH using photorealistic materials
- Majority adherence to the [KiCad Library Conventions][URL-KLC] version 3.0.34

&nbsp;



***How do I use this library?***
================================

- Ensure you are running KiCad 7.0 or later
- Download the most recent [release][URL-releases] of the library
- Unzip the file contents
- If not already created, create a new KiCad project
- Move the root library directory `RaspberryPi_Pico/` to a folder anywhere within your KiCad project
  > *If using the library globally, move `RaspberryPi_Pico/` to a globally accessible location*
- Open the relevant KiCad project
- Select `Preferences > Manage Footprint Libraries...`
- Select the `Project Specific Libraries` tab
  > *If using the library globally, select the `Global Librarires` tab instead*
- Click the folder icon in the lower left to `Add Existing`
- Navigate to and select `.../RaspberryPi_Pico/Module_RaspberryPi_Pico.pretty/`
- Click `OK`
- Select `Preferences > Manage Symbol Libraries...`
- Select the `Project Specific Libraries` tab
  > *If using the library globally, select the `Global Libaries` tab instead*
- Click the folder icon in the lower left to `Add existing library to table`
- Navigate to and select `.../RaspberryPi_Pico/MCU_Module_RaspberryPi_Pico.kicad_sym`
- Click `OK`

To use, simply add a symbol to your schematic as you would any other; symbols should be located under the section `MCU_Module_RaspberryPi_Pico`, and footprints under `Module_RaspberryPi_Pico`.

### **You're all set to design exciting new circuit boards using the Raspberry Pi Pico! 🎉**

&nbsp;



***Further reading***
=====================

## Other KiCad implementations of the Raspberry Pi Pico:

*Some adjacent solutions I encountered during my research for this project*

- Official Raspberry Pi KiCad library files for the Pico and Pico W provided in
  [Hardware design with the RP2040, Section 3][URL-official-example]
    - <https://datasheets.raspberrypi.com/rp2040/VGA-KiCAD.zip>
    - <https://datasheets.raspberrypi.com/rp2040/VGA-PicoW-KiCAD.zip>
- A detailed SketchUp model of the surface-mount Pico incorporating the above
  Pico library
  - <https://github.com/ncarandini/KiCad-RP-Pico>
- A similarly versatile library found on the [KiCad forums][URL-KiCad-forums]
  for all the Pico variants, including a castellated *add-on board* footprint
  - <https://gitlab.com/mgyger/kicad-symbols/-/blob/pico/MCU_Module.kicad_sym>
  - <https://gitlab.com/mgyger/kicad-footprints/-/tree/pico/Module.pretty>

## Pico W antenna radiation pattern resources:

- Great teardown featured:
  - <https://electronupdate.blogspot.com/2022/07/raspberry-pi-pico-w-silicon-level.html>
    - <https://youtu.be/dWJE1ALMlBw>
- Antenna info:
  - <https://www.antenna-theory.com/design/raspberry-pi-antenna.php>
    - <https://youtu.be/MQ8gCsPoo6k>
  - <https://www.tablix.org/~avian/blog/archives/2022/03/effect_of_ground_cutout_on_the_cm4_antenna/>
- Possible antenna radiation pattern:
  - <https://abracon.com/parametric/antennas/PRO-EB-592>
    - <https://abracon.com/datasheets/PRO-EB-592.pdf>
  - <https://abracon.com/parametric/antennas/PRO-EB-594>
    - <https://abracon.com/datasheets/PRO-EB-594.pdf>
  - <https://embeddedcomputing.com/technology/analog-and-power/power-semiconductors-wireless-charging/a-lesson-in-wireless-engineering-from-the-raspberry-pi>
  - <https://antennatestlab.com/antenna-examples/raspberry-pi-model-3b-antenna-evaluation-gain-pattern>

&nbsp;



***License / Access***
======================

This work is made freely available under the [*MIT-0*][URL-MIT-0]
license, the text of which should be found in [`LICENSE.txt`](./LICENSE.txt)
in the root directory of this project alongside this `README`.

*No additional/conflicting permission notices were present in the source repository at the time of release.*

----------------------

*Repository: <https://gitlab.com/recursivenomad/ki-lime-pi-pico/>*  
*Releases: <https://gitlab.com/recursivenomad/ki-lime-pi-pico/-/releases/>*  
*Contact: <recursivenomad@protonmail.com>*

----------------------



[URL-KiCad-forums]: <https://forum.kicad.info/t/are-there-pi-pico-library-files-available-for-kicad-6/35844/12>
[URL-KLC]: <https://klc.kicad.org/>
[URL-MIT-0]: <https://opensource.org/license/mit-0/>
[URL-official-example]: <https://datasheets.raspberrypi.com/rp2040/hardware-design-with-rp2040.pdf#page=15>
[URL-releases]: <https://gitlab.com/recursivenomad/ki-lime-pi-pico/-/releases/>
