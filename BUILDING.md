**Instructions for building from source**
===========================================

> *Note that this project was largely leveraged for becoming more familiar with various aspects of KiCad, FreeCAD, and the Raspberry Pi Pico, and certain files may use exploratory workflows as a result.*

&nbsp;


# Development Environment

  Parametric models exported using [FreeCAD 0.21.2](https://github.com/FreeCAD/FreeCAD/releases/tag/0.21.2) with the [KiCad StepUp 12.2.6](https://github.com/easyw/kicadStepUpMod/tree/a7da10da12e405d106e1e9eb551444a289859ee8) workbench addon

  If you plan on committing changes to the .FCStd document and want (somewhat) trackable commits, then from the repository root call:

  ```bash
  mkdir -p .git/hooks
  cp .githooks/pre-commit.sh .git/hooks/pre-commit
  git config --local core.hooksPath .git/hooks
  ```

  *(If you are already using a `pre-commit` git hook, then manually add the content of `pre-commit.sh` to the existing hook instead)*

  > *Copying the file at a known state curbs the security concerns of remote changes to a hook.  Always audit scripts before using them.*

  Exported VRML models modified in [VSCodium 1.74.3](https://github.com/VSCodium/vscodium/releases/tag/1.74.3.23010)

  KiCad symbols and footprints exported using [KiCad 8.0.3](https://github.com/KiCad/kicad-source-mirror/releases/tag/8.0.3)

&nbsp;


# Symbols and Footprints

  KiCad symbols and footprints are already in the appropriate directories, so nothing needs to be done to prepare them for export.

&nbsp;


# Models

<details><summary>Regarding parametric colours</summary>
  
  > *Model faces are parametrically coloured via boolean operations between parts of varying diffuse colours.  To alter source colours for the board, see `Parametric_Source > Boards_Source > Parametric Board Colour Sources` in the `Tree view` panel and modify each Body's `Appearance`.  To alter source colours for components, be sure to modify the `Appearance` of the source Bodies **directly**, which are contained within the compounds/part containers in `Parametric_Source > Pico_Components_Source`.  Modifying the `Appearance` of the compounds/part containers or setting parts' face colours with `Set Colors...` will **not** parametrically populate.*
  >
  > *Note that as of FreeCAD 0.20.2 changing the sources of the colours does not automatically populate down all the dependent objects.  To get around this if you make any colour changes, when you are ready to export be sure to recompute the entire document as detailed below.  This should successfully populate the parametric colours across all dependent objects.*
  
</details>


  ### General

  - Open the models source file at `.../ki-lime-pi-pico/models/RaspberryPi_Pico_Variations.FCStd` in FreeCAD

    > Note: ~~If reproducible builds are important, be sure to stash any local changes to the file and reopen it before building so that you are recomputing from a known commit.~~  
    > ~~This is particularly important if you are using the `pre-commit` git hook described above.~~  
    > There is inconsistent noise generated with each recompute/export.  As a result, reproducible builds are not possible as built models will slightly differ each time.
  
  - If not already marked to recompute, in FreeCAD's `Tree view` panel `right-click` on the root document name `RaspberryPi_Pico_Variations` and select `Mark to recompute`

  - Click `Edit > Refresh` (or press `F5`) to recompute the entire document


  ### VRML

  - Enter the KiCad StepUp addon workbench from the drop-down menu at the top of the window

  - In FreeCAD's `Tree view` panel, locate the contents of the folder `Export > KiCad Model Outputs > VRML - Manually Coloured Clones`

  - If you are building from an official release commit, select the `Clone` you wish to export to a VRML file for KiCad (for example: `RaspberryPi_Pico`)  
    If you are building from a custom modification, you will likely need to recreate the `Draft Clones` from the parametrically coloured `Compounds` in `Export > KiCad Model Outputs > STEP - Parametrically Coloured Compounds`

    <details><summary>Additional information regarding clones and colours</summary>
      
      > *KiCad StepUp provides a selection of fully-featured materials that can be exported to VRML files.  Although the selection is limited, it provides convenient labelling of materials that can be edited later.  I have created `Clones` of each variation (which as of FreeCAD 0.20.2 do **not** parametrically preserve colour) and pre-set each face colour to align with colours defined within KiCad StepUp.*
      >
      > *Note that if you change geometry in any way which alters the number or topological location of faces anywhere within the model, these pre-set `Clones` will no longer be coloured appropriately*
      >
      > *You can always export from the parametrically coloured `Compounds` in `Export > KiCad Model Outputs > STEP - Parametrically Coloured Compounds`, just needing to set the export colours in KiCad StepUp each time as they will be reset upon recomputes.*
      
    </details>

  - Click on KiCad StepUp's `Export 3D Model` button (a graphic of a black 6-pin IC with a green arrow pointing down and to the right)

  - When prompted, I have used the values of `0.03 Mesh Deviation` and `0.5 creaseAngle` (old default values) and I find the results to be acceptable

  - If you are building from an official release commit, simply accept all the KiCad StepUp colour association prompts  
    If you are building from newly created `Clones`, you will need to manually set KiCad StepUp's colour associations.
    
    <details> <summary> Additional information regarding KiCad StepUp colour association </summary>
    
      > This part can be frustrating, as many parts appear off-white but are different materials.
      > When I built it, there are some colours which are automatically associated to a named material in KiCad StepUp; you shouldn't have to alter those.  
      > The remaining non-automatic colours broadly presented themselves in the following order:
      >
      > - `metal silver` (soldered pads)
      > - `pcb green`
      > - `light brown label` (FR4 core)
      > - `yellow body` (gold pins)
      > - `brown body` (caps)
      > - `resistor black body` (res/diode)
      > - `led white` (led lens)
      > - `light brown body` (led board)
      > - `green body` (led phosphor)
      > - `metal grey` (oscillator/wifi package)
      >
      > If this list doesn't appear to be accurate for you, then you can always set each colour to a high-contrasting material, and then select the appropriate material association in a second round of exporting.

    </details>

  - Repeat this for all `Clones`

  - Prepare a powerful text editor for bulk file editing

    <details> <summary> Specific instructions for preparing VSCodium/VSCode</summary>

      - Open a new VSCode-based instance

      - Select `File > Open Folder...`

      - Navigate to the directory `.../ki-lime-pi-pico/`

      - Select the folder `models/` and click `Select Folder`

      - Open each `.wrl` file by `double-clicking` each file in the `Explorer` pane

      - Select the magnifying glass on the left to open the `Search` pane

      - Expand the search box with the arrow to its left to reveal its find-and-replace functionality

      - Click the `...` in the bottom-right of the find-and-replace fields to expand additional options

      - Select the graphic of an open book in the `files to include` field to only process files which are currently open

    </details>

  - Find and replace the following material names in the newly created `.wrl` files:

    > *Be sure **not** to replace these material names in `MaterialsList.txt`!*

    | Original material   | Replace with
    |:-------------------:|:------------:
    | `PLASTIC-YELLOW-01` | `FINISH-GOLD`
    | `MET-SILVER`        | `FINISH-SILVER`
    | `RES-SMD-01`        | `IC-BODY-EPOXY-02`
    | `CAP-CERAMIC-06`    | `CAP-CERAMIC-01`
    | `MET-01`            | `FINISH-TIN`
    | `IC-LABEL-01`       | `BOARD-FR4-NATURAL`
    | `BOARD-GREEN-02`    | `MASK-PINE-GREEN`
    | `RES-THT-01`        | `MASK-LIGHT-TAN`
    | `LED-WHITE`         | `LED-LENS-CLEAR`
    | `PLASTIC-GREEN-01`  | `EMISSIVE-GREEN-PHOSPHOR`
  ##  
  - Finally, replace the default KiCad StepUp material definitions at the start of each `.wrl` file with the expanded list of materials found in `MaterialsList.txt`

    > *In VSCode-based editors, selecting `Match Case` in the search allows for the large blocks of material definition text to successfully be found and replaced*

    ---

  &nbsp;

  > *KiCad StepUp will automatically generate STEP files with limited hierarchy, part naming, and colour information as a result of the process above, so next we will export STEP models with more detailed information.*

  > *As of the time of writing, KiCad does not appropriately handle exporting part face colours when the component's STEP file uses assemblies.  To get around this, we will export our STEP models as `Compounds` for KiCad.  This will still result in limited hierarchy and part naming information, but will at least preserve face colours (excluding transparency) and discrete sub-components.*



  ### STEP (for KiCad)

  - In FreeCAD's `Tree view` panel, shift focus to the contents of the folder `Export > KiCad Model Outputs > STEP - Parametrically Coloured Compounds`

  - Manually select the root body you wish to export (for example: `RaspberryPi_Pico_Compound`)

  - Press `Ctrl + E`, or select `File > Export`

  - For ease, ensure the directory matches where KiCad StepUp exported its files to:
    `.../ki-lime-pi-pico/models/`

  - Ensure file type `"STEP with colors (*.step *.stp)"` is selected

  - Select the name of the already-generated model you intend to replace (for example: `RaspberryPi_Pico.step`)

  - Select `Save`, and select `Yes` when asked to replace the existing file

  - Repeat this for all models

  - Once all 3D models have been exported as `.wrl` and `.step` files, navigate to:

  ```
  .../ki-lime-pi-pico/models/
  ```

  - And **copy** (don't remove!) all `.wrl` and `.step` files to:

  ```
  .../ki-lime-pi-pico/kicad/project-libraries/RaspberryPi_Pico/Module_RaspberryPi_Pico.3dshapes/
  ```

  ---
  > *In addition to these KiCad models, we can also export a second set of STEP files to a supplemental directory, in the event any users have a need for the fully-featured assemblies.  Feel free to skip this section if all you need is a standalone KiCad library.*

  ### STEP (fully featured supplement)

  - In FreeCAD's `Tree view` panel, navigate into the folder `Export > STEP Assembly`

  - Manually select the root body you wish to export (for example: `RaspberryPi_Pico_STEP`)

  - Press `Ctrl + E`, or select `File > Export`

  - For ease, ensure again the directory matches where KiCad StepUp exported its files to:
    `.../ki-lime-pi-pico/models/`

  - Ensure file type `"STEP with colors (*.step *.stp)"` is selected

  - Select the name of the already-generated model you intend to replace again (for example: `RaspberryPi_Pico.step`)

  - Select `Save`, and select `Yes` when asked to replace the existing file

    > *As a result of using empty `Group` folders as a source of parametric part/feature naming, exporting these parts will result in an expected warning in the `Report view`.*

  - Repeat this for all models

  - Once these 3D models have been exported as `.step` files, navigate to:
  ```
  .../ki-lime-pi-pico/models/
  ```

  - And copy all `.step` files to:

  ```
  .../ki-lime-pi-pico/models/RaspberryPi_Pico_STEP/
  ```

  ### File cleanup

  - Navigate to `.../ki-lime-pi-pico/models/`

  - Delete the previously copied `.wrl` and `.step` files, as they are no longer needed in this directory

&nbsp;


# Final recommendations

As desired, navigate to our source's root directory:

```
.../ki-lime-pi-pico/
```

Append, replace, or otherwise modify files such as `LICENSE.txt`, `ATTRIBUTION.md`, and `README.md` to appropriately reflect your needs.

Copy the desired files *(for example, I include all three of `LICENSE.txt`, `ATTRIBUTION.md`, and `README.md` with the final build)* to:

```
.../ki-lime-pi-pico/kicad/project-libraries/RaspberryPi_Pico/
```

*I prefer to remove the references to images in the built library's `README.md` once it's copied here to keep it clean and compact.*

If you are also exporting the fully-featured supplemental STEP models, copy the desired files *(for example, I include `LICENSE.txt` and `ATTRIBUTION.md`)* to:

```
.../ki-lime-pi-pico/models/RaspberryPi_Pico_STEP/
```

&nbsp;


# **All done!** 🎉

Your completed library to reference, copy, and distribute as you wish can be found at:

```
.../ki-lime-pi-pico/kicad/project-libraries/RaspberryPi_Pico/
```
