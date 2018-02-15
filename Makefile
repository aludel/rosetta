.PHONY: all c java perl clean

all: c java perl

c:
	cd c && $(MAKE)

clean:
	cd c && $(MAKE) clean
