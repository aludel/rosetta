.PHONY: all tests doc clean

all: RPNparser/*.java
	javac RPNparser/*.java

tests: all test.sh
	sh test.sh

doc: ;

clean:
	rm -f RPNparser/*.class
