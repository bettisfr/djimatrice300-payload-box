# DJI Matrice 300 Payload Box

OpenSCAD model for a DJI Matrice 300 payload box intended to hold a Raspberry Pi 5, DJI E-Port hardware, and related cabling.

The design includes:

- Matrice 300 mounting hole pattern: `78 x 66 mm`
- lower mounting frame with two rear rails
- raised payload box with cable pass-throughs
- separate screw-mounted lid with internal lip
- internal triangular screw reinforcements
- color-coded OpenSCAD preview

## Files

- `djimatrice300-payload-box.scad` - main parametric OpenSCAD model

## Key Dimensions

- M300 hole spacing: `78 x 66 mm`
- lower rear rail outer width: `71 mm`
- box outer width: `86 mm`
- box inner width: about `82 mm`
- box inner length: about `179.5 mm`
- vertical clearance between lower frame and upper plate: `21 mm`
- box wall thickness: `2 mm`
- lid thickness: `1.5 mm`

The model currently exports as two separate printable components:

1. main body
2. lid

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
openscad -o djimatrice300-payload-box.stl djimatrice300-payload-box.scad
```

## Notes

- The colored preview is for inspection only; standard STL export does not preserve colors.
- Screw holes are modeled as plain cylindrical holes, not threaded.
- For plastic screws/self-tapping use, consider tuning pilot hole diameters for the chosen screw and material.
- Check cable routing and connector clearance before final printing.
