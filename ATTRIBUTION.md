# Ki-Lime Pi Pico project attributions



## Peter S. Hollander

Model, footprint, and symbol source files and documentation created and compiled by Peter S. Hollander between 2022 and 2024, and made freely available under your choice of the [*MIT-0*](./LICENSE.txt) license or the [*CC0 1.0 Universal*][URL-CC0] public domain dedication.

*Contact: <recursivenomad@protonmail.com>*  
*Repository: <https://gitlab.com/recursivenomad/ki-lime-pi-pico/>*



## Markus Gyger

Comprehensive alternate pin definitions as defined in the RP2040 datasheet inspired by the [schematic symbol][URL-Gyger-Symbol] created by Markus Gyger.

Including the BOOTSEL button and LED in footprint Fab layers was also inspired by Markus's [footprints][URL-Gyger-Footprints].



## Raspberry Pi

Original assets which were referenced for geometry/organization (model, symbol, footprint) acquired from Raspberry Pi in 2022 via:

- [Raspberry Pi Pico Datasheet][URL-Pico-Sheet]
  - Pico Model: <https://datasheets.raspberrypi.com/pico/Pico-R3-step.zip>
- [Raspberry Pi Pico W Datasheet][URL-Pico-W-Sheet]
  - Pico W Model: <https://datasheets.raspberrypi.com/picow/PicoW-step.zip>
- [RP2040 Datasheet][URL-RP2040-Sheet]
- [Hardware design with the RP2040][URL-RP2040-Design]
  - RP2040 Symbol: <https://datasheets.raspberrypi.com/rp2040/Minimal-KiCAD.zip>
  - Pico Footprint: <https://datasheets.raspberrypi.com/rp2040/VGA-KiCAD.zip>
  - Pico W Footprint: <https://datasheets.raspberrypi.com/rp2040/VGA-PicoW-KiCAD.zip>

&nbsp;






# Tools utilized

- [KiCad][URL-KiCad] - Footprint/symbol library design
- [FreeCAD][URL-FreeCAD] - Parametric 3D modelling
  - [KiCad StepUp addon][URL-KiCad-StepUp] - VRML model exporting
- [VSCodium][URL-VSCodium] - VRML model material bulk editing
- [KiCad Library utilities][URL-KiCad-Utils] - Python scripts to ensure adherence to KiCad Library Conventions






[URL-MIT-0]: <https://opensource.org/license/mit-0/>
[URL-CC0]: <https://creativecommons.org/publicdomain/zero/1.0/>

[URL-FreeCAD]: <https://www.freecad.org/>
[URL-KiCad]: <https://www.kicad.org/>
[URL-KiCad-StepUp]: <https://github.com/easyw/kicadStepUpMod>
[URL-VSCodium]: <https://vscodium.com/>
[URL-KiCad-Utils]: <https://gitlab.com/kicad/libraries/kicad-library-utils>

[URL-Gyger-Footprints]: <https://gitlab.com/mgyger/kicad-footprints/-/tree/pico/Module.pretty>
[URL-Gyger-Symbol]: <https://gitlab.com/mgyger/kicad-symbols/-/blob/pico/MCU_Module.kicad_sym>
[URL-Pico-Sheet]: <https://datasheets.raspberrypi.com/pico/pico-datasheet.pdf>
[URL-Pico-W-Sheet]: <https://datasheets.raspberrypi.com/picow/pico-w-datasheet.pdf>
[URL-RP2040-Design]: <https://datasheets.raspberrypi.com/rp2040/hardware-design-with-rp2040.pdf>
[URL-RP2040-Sheet]: <https://datasheets.raspberrypi.com/rp2040/rp2040-datasheet.pdf>
