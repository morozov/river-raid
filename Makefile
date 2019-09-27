River-Raid.scl: River-Raid.trd
	trd2scl River-Raid.trd River-Raid.scl

# The compressed screen is created by Laser Compact v5.2
# and cannot be generated at the build time
# see https://spectrumcomputing.co.uk/?cat=96&id=21446
River-Raid.trd: boot.$$B hob/screenz.$$C data.$$C
# Create a temporary file first in order to make sure the target file
# gets created only after the entire job has succeeded
	$(eval TMPFILE=$(shell tempfile))

	createtrd $(TMPFILE)
	hobeta2trd boot.\$$B $(TMPFILE)
	hobeta2trd hob/screenz.\$$C $(TMPFILE)
	hobeta2trd data.\$$C $(TMPFILE)

# Rename the temporary file to target name
	mv $(TMPFILE) River-Raid.trd

boot.$$B: boot.000
	0tohob boot.000

boot.000: boot.tap
	tapto0 -f boot.tap

boot.tap: boot.bas
	bas2tap -sboot -a10 boot.bas boot.tap

boot.bas: src/boot.bas loader.bin
# Replace the __LOADER__ placeholder with the machine codes with bytes represented as {XX}
	sed "s/__LOADER__/$(shell hexdump -e '1/1 "{%02x}"' loader.bin)/" src/boot.bas > boot.bas

loader.bin: src/loader.asm
	pasmo --bin src/loader.asm loader.bin

data.$$C: data.000
	0tohob data.000

data.000: data.bin
	rm -f data.000
	binto0 data.bin 3

data.bin: src/depacker.asm buffer.zx7 LERN.zx7 Prog.patched.zx7
	pasmo --bin src/depacker.asm data.bin

controls.bin: src/controls.asm
	pasmo --bin src/controls.asm controls.bin

buffer.zx7: buffer.cod
	zx7 buffer.cod buffer.zx7

buffer.cod: buffer.000
	0tobin buffer.000

LERN.zx7: LERN.cod
	zx7 LERN.cod LERN.zx7

LERN.cod: LERN.000
	0tobin LERN.000

Prog.patched.bas: Prog.bas controls.bin
	cp Prog.bas Prog.patched.bas
# The output offset is the relative offset of the start memory address being patched to the start address of the file:
# 0x607A (see src/controls.asm) - 0x5CCB (where PROG points) = 0x3AF (or 943 decimal)
	dd if=controls.bin of=Prog.patched.bas obs=1 seek=943 conv=notrunc

Prog.patched.zx7: Prog.patched.bas
	zx7 Prog.patched.bas Prog.patched.zx7

Prog.bas: Prog.000
	0tobin Prog.000

buffer.000 LERN.000 Prog.000: River\ Raid\ (1984)(Activision)[a].tap
	tapto0 -f "River Raid (1984)(Activision)[a].tap"

River\ Raid\ (1984)(Activision)[a].tap: River\ Raid\ (1984)(Activision)[a].tzx
	tzx2tap "River Raid (1984)(Activision)[a].tzx"

River\ Raid\ (1984)(Activision)[a].tzx:
# The disctribution of the image is denied on WoS (http://www.worldofspectrum.org/infoseekid.cgi?id=0004154),
	wget https://zxaaa.net/DENIED/River%20Raid%20%281984%29%28Activision%29.tzx -O "River Raid (1984)(Activision)[a].tzx"

clean:
	rm -f \
		*.000 \
		*.\$$B \
		*.\$$C \
		*.bas \
		*.bin \
		*.cod \
		*.tap \
		*.trd \
		*.tzx \
		*.zx7
