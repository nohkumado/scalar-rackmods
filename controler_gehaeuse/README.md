# Scalar XLP rack mods — relocated controller case & anti-vibration feet

OpenSCAD-designed, 3D-printable parts for the **Scalar XLP** printer that move
the RAMPS controller and its display off the top of the machine onto the
frame/rack, plus feet that damp the vibrations the printer transmits to the
bench.

## Why

On the stock Scalar XLP the controller sits on top of the printer. In my setup
that is impractical:

- the RAMPS card is hard to insert/extract in that position,
- the display is barely readable from where I stand,
- and it forces all the wiring to be threaded to the top of the machine, which
  turned the cabling into a mess.

These parts relocate the electronics to the frame and give the printer a set of
vibration-absorbing feet.

## Parts

| File | What it is |
|------|------------|
| `ballfoot.scad` | Anti-vibration foot that clamps onto the 30×30 aluminium extrusion; a Ø35.8 mm ball sits in a socket to decouple the frame from the bench. |
| `Maincase.scad` | Main enclosure housing the RAMPS board and a Raspberry Pi (3B), mounted on the frame. |
| `Hauptplatine.scad` | Mounting plate / frame for the main board (≈150×56 mm). |
| `display.scad` | Housing for the controller display. |
| `Displaydeckel.scad` | Front cover / bezel for the display housing. |
| `PiHoles/` | Raspberry Pi mounting-hole pattern (git submodule → [daprice/PiHoles](https://github.com/daprice/PiHoles)). |
| `img/` | Photos of the printed parts installed on the printer. |

## Building

Open the `.scad` files in [OpenSCAD](https://openscad.org/) and render/export the
STL you need. The models pull in a couple of shared libraries from the parent
[`scalar-rackmods`](https://github.com/nohkumado/scalar-rackmods) repo
(`../masken/metrische_masken.scad`, the 30×30 extrusion profile —
[Thingiverse #884966](https://www.thingiverse.com/thing:884966)), so build from a
full checkout of that repo with submodules initialised:

```bash
git clone --recurse-submodules https://github.com/nohkumado/scalar-rackmods.git
```

## License

GPL-3.0 — see [`LICENSE`](LICENSE).
