.PHONY: all tests clean

all:
	for d in $(shell ./list-examples); do (cd $$d && $(MAKE)); done

tests:
	for d in $(shell ./list-examples); do (cd $$d && $(MAKE) tests); done
	
clean:
	for d in $(shell ./list-examples); do (cd $$d && $(MAKE) clean); done
