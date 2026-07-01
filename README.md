# DJI Matrice 300 Payload Box

OpenSCAD model for a DJI Matrice 300 payload box intended to hold a Raspberry Pi 5, DJI E-Port hardware, and related cabling.

| Assembly | Box |
| --- | --- |
| ![Assembly preview](preview/assembly.png) | ![Box preview](preview/box.png) |

| Frame | Lid |
| --- | --- |
| ![Frame preview](preview/frame.png) | ![Lid preview](preview/lid.png) |

The design includes:

- Matrice 300 mounting hole pattern: `78 x 66 mm`
- lower mounting frame with two rear rails
- two rear half-diagonal braces for tail reinforcement
- raised payload box with cable pass-throughs
- separate screw-mounted lid with internal lip
- internal triangular screw pads with M3 nut traps
- color-coded OpenSCAD preview

## Files

- `djimatrice300-payload-box.scad` - main parametric OpenSCAD model
- `preview/` - rendered preview images for the assembly and printable components

## Key Dimensions

- M300 hole spacing: `78 x 66 mm`
- lower rear rail outer width: `71 mm`
- rear cross-brace clear distances from AB: `70 mm`, `110 mm`, `150 mm`
- rear half-diagonal braces: from `E` and `F` to the midpoint of the last rear cross brace
- box outer width: `94.5 mm`
- box inner width: about `90.5 mm`
- box inner length: about `189.5 mm`
- lower frame thickness: `5 mm`
- vertical clearance between lower frame and upper plate: `18.5 mm`
- box wall thickness: `2 mm`
- lid thickness: `1.5 mm`
- M3 clearance holes: `3.2 mm`
- DJI mounting bolt seats: `6 mm` diameter, `3.5 mm` deep
- frame-to-standoff screw head slots: `5.8 x 7 mm`, `1.2 mm` deep, on the frame
- box floor screw head counterbores: `5.8 mm` diameter, `1.2 mm` deep
- lid nut traps: M3 hex nuts, `5.8 mm` flat-to-flat clearance, `2.8 mm` deep

## Required Hardware

- 6x M3 female-female standoffs, bought separately, for the frame-to-box connection
- M3 screws for both sides of each standoff, typically `M3x6` or `M3x8`
- 4x M3 hex nuts for the lid screw traps
- 4x M3 screws for the lid

The model can be exported in separate components for inspection and FDM printing:

1. full assembly preview
2. payload box
3. lower mounting frame
4. lid

Use the `part` parameter in `djimatrice300-payload-box.scad` to choose what to export:

- `part = "assembly";` - full inspection preview with the lid raised above the box
- `part = "box";` - payload box only, placed with its floor on the print bed and box-to-frame holes
- `part = "frame";` - lower mounting frame only, flipped onto its continuous top face with matching box-to-frame holes
- `part = "lid";` - lid only, flipped for FDM printing with the outer flat face on the build plate

Set `show_labels = true;` to show preview-only labels in the assembly view. Labels are disabled by default so exported STLs stay clean unless explicitly enabled.

## OpenSCAD Usage

Open the model:

```bash
openscad djimatrice300-payload-box.scad
```

Useful shortcuts:

- `F5` preview
- `F6` render
- `File -> Export -> Export as STL`

Command-line STL export:

```bash
openscad -o djimatrice300-payload-box-box.stl -D 'part="box"' djimatrice300-payload-box.scad
openscad -o djimatrice300-payload-box-frame.stl -D 'part="frame"' djimatrice300-payload-box.scad
openscad -o djimatrice300-payload-box-lid.stl -D 'part="lid"' djimatrice300-payload-box.scad
```

## Notes

- The colored preview is for inspection only; standard STL export does not preserve colors.
- Do not export `part="assembly"` for printing; it is intended for visual inspection only.
- The `assembly` preview shows the split design with six M3 standoffs between the frame and box.
- The `frame` export prints upside down on the continuous top face of the lower frame, so the DJI spacers grow upward instead of starting from disconnected islands.
- The `box` and `frame` exports include matching box-to-frame holes for M3 female-female standoffs.
- The lid screws use M3 nut traps inside the box screw pads.
- Screw holes are modeled as plain cylindrical holes, not threaded.
- For plastic screws/self-tapping use, consider tuning pilot hole diameters for the chosen screw and material.
- Check cable routing and connector clearance before final printing.
