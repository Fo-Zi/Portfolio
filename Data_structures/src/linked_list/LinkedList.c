#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#include "LinkedList.h"

struct node {
	int data;
	struct node *next;
};

struct list{
	Node *head;
	uint16_t size;
};

bool add_node(int data, List *list){
	Node *current = list->head;
	Node *newNode = (Node *) malloc(sizeof(Node));
	if(newNode==NULL){
		return false;
	}
	if(current==NULL){
		list->head = newNode;
	}
	else{
		while(current->next!=NULL){
			current = current->next;
		}
		current->next = newNode;
	}
	newNode->data = data;
	newNode->next = NULL;
	list->size+=1;
	return true;
}

bool remove_node(int data, List *list){
	Node *current = list->head;
	Node *previous = NULL;
	if(current==NULL){
		return false;
	}	
	while(current->data!=data){
		previous = current; 
		current = current->next;
	}
	if(current->next==NULL){	
		previous->next = NULL;
		free(current);
	}else{
		previous->next = current->next;
		free(current);
	}
	list->size=1;
	return true;
}

uint16_t length_list(List *list){
	return (list->size);
}
