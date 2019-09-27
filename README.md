# Disk version of River Raid for ZX Spectrum

Despite the fact that there are many existing [disk versions](https://vtrd.in/games.php?t=r) of [River Raid](http://www.worldofspectrum.org/infoseekid.cgi?id=0004154), I decided to create my own. Unlike the existing ones, it doesn't contain any intros or cheats which would require the user to press different keys before being able to play and cuts right to the chase.

<p align="center">
    <img src="https://raw.githubusercontent.com/morozov/river-raid/master/png/screen.png" width="512" height="384" alt="River Raid">
</p>

## Used tools

1. [Pasmo](http://pasmo.speccy.org/), a portable Z80 cross assembler.
2. [zxspectrum-utils](https://sourceforge.net/projects/zxspectrumutils/), [bas2tap](https://github.com/speccyorg/bas2tap), [trd2scl](http://www.worldofspectrum.org/pub/sinclair/tools/generic/trd2scl-1.0.0.tar.gz) for conversion of the files between various formats.
3. [ZX7](http://www.worldofspectrum.org/infoseekid.cgi?id=0027996) for data compression.
4. [Screen Optimizer v4.2](http://www.worldofspectrum.org/infoseekid.cgi?id=0021314) and [Laser Compact v5.2](http://www.worldofspectrum.org/infoseekid.cgi?id=0021446) for loading screen optimization and compression.
5. [Fuse](https://sourceforge.net/projects/fuse-emulator/) for debugging and testing.

## Key features

1. The tape loader has been replaced with the one for TR-DOS.
2. The loading screen has been optimized and compressed to 22% of its original size.
3. The entire SCL image is 19KB compared to the original 47KB tzx.
4. The "FASTER" and "SLOWER" keys are remapped from `2` and `W` to `Q` and `A` respectively.
5. The resulting image is a monoblock (one *.B file contains all the data).

## Inspirations

1. [Disk version by ZDW'97](https://vtrd.in/gamez/r/RIVER_R_.ZIP). It helped me understand that the existing disk versions are smaller than the original due to used data compression, not because some data is unnecessary. Also, showed the idea of remapping keyboard controls.
2. [Disk version by Be-Be Software'85](https://vtrd.in/gamez/r/RRAID_BE.zip). The idea that some of the system variables need to be set it their 48K values to let the game start.

## Usage

1. Install [Pasmo](http://pasmo.speccy.org/), [zxspectrum-utils](https://sourceforge.net/projects/zxspectrumutils/), [bas2tap](https://github.com/speccyorg/bas2tap), [ZX7](http://www.worldofspectrum.org/infoseekid.cgi?id=0027996) and [trd2scl](http://www.worldofspectrum.org/pub/sinclair/tools/generic/trd2scl-1.0.0.tar.gz).
2. Run `make`.
3. Use the resulting `River-Raid.scl`.
