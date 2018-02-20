#ifndef _STACK_H_
#define _STACK_H_

typedef struct stack_item StackItem;
typedef struct stack Stack;


Stack *stack_create(void);
void stack_destroy(Stack *stack);

StackItem *stack_push(Stack *stack, int value);
StackItem *stack_pop(Stack *stack, int *value);

size_t stack_size(Stack *stack);

#endif  /* _STACK_H_ */
