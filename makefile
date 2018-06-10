SRCFILES=src/fake86/*.c
BINPATH=/usr/bin
DATAPATH=/usr/share/fake86
CFLAGS=-O0 -DPATH_DATAFILES=\"$(DATAPATH)/\" -ggdb -Wall -Wextra -Wpedantic
INCLUDE=-Isrc/fake86
LIBS=-lpthread -lX11
SDLFLAGS=`sdl-config --cflags --libs`

all: bin/fake86 bin/imagegen

bin/fake86: $(SRCFILES) makefile
	$(CC) $(SRCFILES) -o bin/fake86 $(CFLAGS) $(INCLUDE) $(LIBS) $(SDLFLAGS)
	chmod a+x bin/fake86

bin/imagegen: src/imagegen/imagegen.c makefile
	$(CC) -o bin/imagegen $(CFLAGS) src/imagegen/imagegen.c
	chmod a+x bin/imagegen

install:
	mkdir -p $(BINPATH)
	mkdir -p $(DATAPATH)
	chmod a-x data/*
	cp -p bin/fake86 $(BINPATH)
	cp -p bin/imagegen $(BINPATH)
	cp -p data/asciivga.dat $(DATAPATH)
	cp -p data/pcxtbios.bin $(DATAPATH)
	cp -p data/videorom.bin $(DATAPATH)
	cp -p data/rombasic.bin $(DATAPATH)

clean:
	rm -f src/fake86/*.o
	rm -f src/fake86/*~
	rm -f src/imagegen/*.o
	rm -f src/imagegen/*~
	rm -f bin/fake86
	rm -f bin/imagegen

uninstall:
	rm -f $(BINPATH)/fake86
	rm -f $(BINPATH)/imagegen
	rm -f $(DATAPATH)/asciivga.dat
	rm -f $(DATAPATH)/pcxtbios.bin
	rm -f $(DATAPATH)/videorom.bin
	rm -f $(DATAPATH)/rombasic.bin
	rmdir $(DATAPATH)

.PHONY: all install clean uninstall
