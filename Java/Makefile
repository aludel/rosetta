.PHONY: all test clean

all: RPNparser/*.java
	javac RPNparser/*.java

tests: all test.sh
	sh test.sh

clean:
	rm -f RPNparser/*.class
