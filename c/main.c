#include <stdio.h>
#include <stdlib.h>
#include "parser.h"



int
main(int argc, char **argv)
{
	char *line = NULL;
	size_t len = 0;
	ssize_t read;
	int result = 0;


	while ((read = getline(&line, &len, stdin)) != -1) {
		if (parse(line, &result) < 0) {
			printf("ERROR!\n");
		} else {
			printf("%d\n", result);
		}
	}

	free(line);
	exit(EXIT_SUCCESS);
}
