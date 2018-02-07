#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "stack.h"


typedef struct stack_item {
	void *data;
	StackItem *next;
} StackItem;

typedef struct stack {
	StackItem *top;
} Stack;


Stack *
stack_create(void)
{
	Stack *stack;
	
	if ((stack = malloc(sizeof(Stack))) == NULL)
		return NULL;
	
	stack->top = NULL;

	return stack;
}

StackItem *
stack_push(Stack *stack, void *data)
{
	StackItem *item;

	if (stack == NULL)
		return NULL;
	
	if ((item = malloc(sizeof(StackItem))) == NULL)
		return NULL;
	
	item->next = stack->top;
	item->data = data;
	stack->top = item;

	return item;
}

void *
stack_pop(Stack *stack)
{
	StackItem *item;
	void *data;

	if (stack == NULL)
		return NULL;

	if ((item = stack->top) == NULL)
		return NULL;

	stack->top = item->next;
	data = item->data;

	free(item);

	return data;
}

void
stack_destroy(Stack *stack)
{
	void *data;

	if (stack == NULL)
		return;
	
	while ((data = stack_pop(stack)) != NULL) {
		free(data);
	}
	
	free(stack);
}


#if STACK_DEBUG
int
main()
{
	Stack *stack;
	char *line = NULL;
	size_t len = 0;
	ssize_t read;

	if ((stack = stack_create()) == NULL) {
		fprintf(stderr, "Cannot create stack!\n");
		exit(EXIT_FAILURE);
	}

	while ((read = getline(&line, &len, stdin)) != -1) {
		if ((stack_push(stack, strdup(line))) == NULL) {
			fprintf(stderr, "Cannot push onto stack!\n");
			exit(EXIT_FAILURE);
		}
	}

	free(line);

	while ((line = stack_pop(stack)) != NULL) {
		printf("%s", line);
	}

	stack_destroy(stack);
}
#endif  /* STACK_DEBUG */
