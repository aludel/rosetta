.PHONY: all c java perl clean

all: c java perl

c:
	cd c && $(MAKE)

perl:
	cd perl && $(MAKE)

clean:
	cd c && $(MAKE) clean
