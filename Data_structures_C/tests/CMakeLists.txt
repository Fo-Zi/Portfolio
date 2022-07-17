include(FetchContent)

FetchContent_Declare(
	googletest
	GIT_REPOSITORY https://github.com/google/googletest.git
	GIT_TAG		release-1.11.0
)
FetchContent_MakeAvailable(googletest)

add_library(GTest::GTest INTERFACE IMPORTED)

target_link_libraries(GTest::GTest INTERFACE gtest_main)

add_executable(LinkedList_test linked_list_test.cpp main.cpp)

target_link_libraries(
	LinkedList_test
	PRIVATE
	gtest_main	
	LinkedList
)

add_test(LinkedList_gtest LinkedList_test)
