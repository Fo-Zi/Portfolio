#include <gtest/gtest.h>

extern "C"{
	#include "../src/linked_list/LinkedList.h"
}

TEST(LinkedListTest,AddingNodes){
	List *list1;
	ASSERT_EQ(add_node(1,list1),true);
	ASSERT_EQ(add_node(2,list1),true);
	ASSERT_EQ(length_list(list1),2);
}
