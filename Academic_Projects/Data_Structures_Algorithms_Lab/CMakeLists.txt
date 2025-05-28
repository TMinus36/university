cmake_minimum_required(VERSION 3.15)
project(DataStructuresAlgorithms VERSION 1.0.0)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Include directories
include_directories(include)

# Add executable
add_executable(dsa_lab
    main.cpp
    BST.cpp
    Graph.cpp
    LinkedList.cpp
    Sorting.cpp
    Stack.cpp
)

# Enable testing
enable_testing()

# Add tests if any
# add_subdirectory(tests)

# Add installation
install(TARGETS dsa_lab DESTINATION bin)
