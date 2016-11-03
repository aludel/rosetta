#ifndef _STACK_H_
#define _STACK_H_

typedef struct stack_item StackItem;
typedef struct stack Stack;


Stack *stack_create(void);

StackItem *stack_push(Stack *stack, void *data);

void *stack_pop(Stack *stack);

void stack_destroy(Stack *stack);

#endif  /* _STACK_H_ */
