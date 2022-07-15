#ifndef LINKED_LIST_H
#define LINKED_LIST_H
	#include <stdbool.h>	
	#include <stdint.h>

	typedef struct node Node;
	typedef struct list List;

	bool add_node(int data, List *list);
	bool remove_node(int data, List *list);
	uint16_t length_list(List *list);

//	bool addFirst ( List *list );
//	bool removeFirst( List *list );
	
//	void sort(List *list);
//	void printList();
#endif
