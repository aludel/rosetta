CCFLAGS=-Wall

.PHONY: all test clean

all: rpnparser

parser.o: parser.c stack.h
	$(CC) $(CCFLAGS) -c parser.c

stack.o: stack.c stack.h
	$(CC) $(CCFLAGS) -c stack.c

main.o: main.c parser.h stack.h
	$(CC) $(CCFLAGS) -c main.c

rpnparser: parser.o stack.o main.o
	$(CC) $(LDFLAGS) -o rpnparser parser.o stack.o main.o

test: ;

clean:
	rm -f *.o rpnparser
