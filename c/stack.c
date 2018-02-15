#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "stack.h"


typedef struct stack_item {
	int value;
	StackItem *next;
} StackItem;

typedef struct stack {
	StackItem *top;
} Stack;


Stack *
stack_create(void)
{
	Stack *stack;
	if (!(stack = malloc(sizeof(Stack)))) return NULL;
	stack->top = NULL;
	return stack;
}

StackItem *
stack_push(Stack *stack, int value)
{
	StackItem *item;
	if (!stack) return NULL;
	if (!(item = malloc(sizeof(StackItem)))) return NULL;
	item->next = stack->top;
	item->value = value;
	stack->top = item;
	return item;
}

StackItem *
stack_pop(Stack *stack, int *value)
{
	StackItem *item;
	if (!stack || !value) return NULL;
	if (!(item = stack->top)) return NULL;
	stack->top = item->next;
	*value = item->value;
	free(item);
        return item;
}

void
stack_destroy(Stack *stack)
{
	if (!stack) return;
	free(stack);
}

size_t
stack_size(Stack *stack)
{
        size_t size = 0;
	StackItem *item;
	if (!stack) return -1;
        for (item = stack->top; item; item = item->next) size++;
        return size;
}
