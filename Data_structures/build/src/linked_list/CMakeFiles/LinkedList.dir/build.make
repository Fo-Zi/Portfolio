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
include src/linked_list/CMakeFiles/LinkedList.dir/depend.make

# Include the progress variables for this target.
include src/linked_list/CMakeFiles/LinkedList.dir/progress.make

# Include the compile flags for this target's objects.
include src/linked_list/CMakeFiles/LinkedList.dir/flags.make

src/linked_list/CMakeFiles/LinkedList.dir/LinkedList.c.o: src/linked_list/CMakeFiles/LinkedList.dir/flags.make
src/linked_list/CMakeFiles/LinkedList.dir/LinkedList.c.o: ../src/linked_list/LinkedList.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/linked_list/CMakeFiles/LinkedList.dir/LinkedList.c.o"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/src/linked_list && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/LinkedList.dir/LinkedList.c.o   -c /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/src/linked_list/LinkedList.c

src/linked_list/CMakeFiles/LinkedList.dir/LinkedList.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/LinkedList.dir/LinkedList.c.i"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/src/linked_list && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/src/linked_list/LinkedList.c > CMakeFiles/LinkedList.dir/LinkedList.c.i

src/linked_list/CMakeFiles/LinkedList.dir/LinkedList.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/LinkedList.dir/LinkedList.c.s"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/src/linked_list && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/src/linked_list/LinkedList.c -o CMakeFiles/LinkedList.dir/LinkedList.c.s

# Object files for target LinkedList
LinkedList_OBJECTS = \
"CMakeFiles/LinkedList.dir/LinkedList.c.o"

# External object files for target LinkedList
LinkedList_EXTERNAL_OBJECTS =

src/linked_list/libLinkedList.a: src/linked_list/CMakeFiles/LinkedList.dir/LinkedList.c.o
src/linked_list/libLinkedList.a: src/linked_list/CMakeFiles/LinkedList.dir/build.make
src/linked_list/libLinkedList.a: src/linked_list/CMakeFiles/LinkedList.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C static library libLinkedList.a"
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/src/linked_list && $(CMAKE_COMMAND) -P CMakeFiles/LinkedList.dir/cmake_clean_target.cmake
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/src/linked_list && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/LinkedList.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/linked_list/CMakeFiles/LinkedList.dir/build: src/linked_list/libLinkedList.a

.PHONY : src/linked_list/CMakeFiles/LinkedList.dir/build

src/linked_list/CMakeFiles/LinkedList.dir/clean:
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/src/linked_list && $(CMAKE_COMMAND) -P CMakeFiles/LinkedList.dir/cmake_clean.cmake
.PHONY : src/linked_list/CMakeFiles/LinkedList.dir/clean

src/linked_list/CMakeFiles/LinkedList.dir/depend:
	cd /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/src/linked_list /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/src/linked_list /home/lmint-vm/Desktop/Workspace/C/Unit_Testing/Data_structures/build/src/linked_list/CMakeFiles/LinkedList.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/linked_list/CMakeFiles/LinkedList.dir/depend
