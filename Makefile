.PHONY: all test clean

all:
	for d in $(shell ./list-examples); do (cd $$d && $(MAKE)); done

test:
	for d in $(shell ./list-examples); do (cd $$d && $(MAKE) test); done
	
clean:
	for d in $(shell ./list-examples); do (cd $$d && $(MAKE) clean); done
