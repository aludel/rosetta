.PHONY: all tests doc clean

all:
	for d in $(shell ./list-examples); do (cd $$d && $(MAKE)); done

tests:
	for d in $(shell ./list-examples); do (cd $$d && $(MAKE) tests); done
	
doc:
	for d in $(shell ./list-examples); do (cd $$d && $(MAKE) doc); done

clean:
	for d in $(shell ./list-examples); do (cd $$d && $(MAKE) clean); done
