# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build

# Include any dependencies generated for this target.
include tests/CMakeFiles/LinkedList_test.dir/depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/LinkedList_test.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/LinkedList_test.dir/flags.make

tests/CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.o: tests/CMakeFiles/LinkedList_test.dir/flags.make
tests/CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.o: ../tests/linked_list_test.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tests/CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.o"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/tests && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.o -c /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/tests/linked_list_test.cpp

tests/CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.i"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/tests/linked_list_test.cpp > CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.i

tests/CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.s"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/tests/linked_list_test.cpp -o CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.s

tests/CMakeFiles/LinkedList_test.dir/main.cpp.o: tests/CMakeFiles/LinkedList_test.dir/flags.make
tests/CMakeFiles/LinkedList_test.dir/main.cpp.o: ../tests/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object tests/CMakeFiles/LinkedList_test.dir/main.cpp.o"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/tests && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LinkedList_test.dir/main.cpp.o -c /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/tests/main.cpp

tests/CMakeFiles/LinkedList_test.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LinkedList_test.dir/main.cpp.i"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/tests/main.cpp > CMakeFiles/LinkedList_test.dir/main.cpp.i

tests/CMakeFiles/LinkedList_test.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LinkedList_test.dir/main.cpp.s"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/tests && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/tests/main.cpp -o CMakeFiles/LinkedList_test.dir/main.cpp.s

# Object files for target LinkedList_test
LinkedList_test_OBJECTS = \
"CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.o" \
"CMakeFiles/LinkedList_test.dir/main.cpp.o"

# External object files for target LinkedList_test
LinkedList_test_EXTERNAL_OBJECTS =

tests/LinkedList_test: tests/CMakeFiles/LinkedList_test.dir/linked_list_test.cpp.o
tests/LinkedList_test: tests/CMakeFiles/LinkedList_test.dir/main.cpp.o
tests/LinkedList_test: tests/CMakeFiles/LinkedList_test.dir/build.make
tests/LinkedList_test: src/linked_list/libLinkedList.a
tests/LinkedList_test: lib/libgtest_main.a
tests/LinkedList_test: lib/libgtest.a
tests/LinkedList_test: tests/CMakeFiles/LinkedList_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable LinkedList_test"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/LinkedList_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/LinkedList_test.dir/build: tests/LinkedList_test

.PHONY : tests/CMakeFiles/LinkedList_test.dir/build

tests/CMakeFiles/LinkedList_test.dir/clean:
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/tests && $(CMAKE_COMMAND) -P CMakeFiles/LinkedList_test.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/LinkedList_test.dir/clean

tests/CMakeFiles/LinkedList_test.dir/depend:
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/tests /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/tests /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/tests/CMakeFiles/LinkedList_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/LinkedList_test.dir/depend
