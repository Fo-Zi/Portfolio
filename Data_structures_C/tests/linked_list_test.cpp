#include <gtest/gtest.h>

extern "C"{
	#include "../src/linked_list/LinkedList.h"
}

TEST(LinkedListTest,AddingNodes){
	List *list1;
	ASSERT_TRUE(add_node(1,list1) == true);
	ASSERT_TRUE(add_node(2,list1) == true);
	ASSERT_TRUE(length_list(list1) == 2);
}

TEST(LinkedListTest,DeletingNodes){
	List *list2;
	ASSERT_EQ(add_node(1,list2),true);
	ASSERT_EQ(add_node(2,list2), true);
	ASSERT_EQ(remove_node(2,list2), true);
	ASSERT_EQ(remove_node(1,list2),true);
	//ASSERT_EQ(remove_node(10,NULL),false);
//	ASSERT_EQ(length_list(list2),0);
}
