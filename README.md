# Disk version of River Raid for ZX Spectrum

The purpose of this repository is to document and automate the process of creating a TR-DOS version of the game [River Raid](http://www.worldofspectrum.org/infoseekid.cgi?id=0004154) which was originally distributed on casettes.

<p align="center">
    <img src="https://raw.githubusercontent.com/morozov/river-raid/master/png/screen.png" width="512" height="384" alt="River Raid">
</p>

## Used tools

1. [zxspectrum-utils](https://sourceforge.net/projects/zxspectrumutils/), [bas2tap](https://github.com/speccyorg/bas2tap), [trd2scl](http://www.worldofspectrum.org/pub/sinclair/tools/generic/trd2scl-1.0.0.tar.gz) for conversion of the files between various formats.
2. [Fuse](https://sourceforge.net/projects/fuse-emulator/) for debugging and testing.

## Usage

1. Install [zxspectrum-utils](https://sourceforge.net/projects/zxspectrumutils/), [bas2tap](https://github.com/speccyorg/bas2tap) and [trd2scl](http://www.worldofspectrum.org/pub/sinclair/tools/generic/trd2scl-1.0.0.tar.gz).
2. Run `make`.
3. Use the resulting `River-Raid.scl`.
