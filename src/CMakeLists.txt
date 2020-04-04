# find all source cpp files in src folder
file(GLOB_RECURSE SRC_CPP ${CMAKE_CURRENT_LIST_DIR} "*.cpp")
list(FILTER SRC_CPP EXCLUDE REGEX ".*Test.cpp$")

# find all test cpp files in src folder
# the filename of test files should end up with "Test.cpp"
file(GLOB_RECURSE TEST_CPP ${CMAKE_CURRENT_LIST_DIR} "*Test.cpp")

# set library name
set(LIB_NAME demo)

# compile source files to a static library
add_library(${LIB_NAME} ${SRC_CPP})

# add current folder to include directories for current target
include_directories(${CMAKE_CURRENT_LIST_DIR})

# add current folder to include directories for clients of current target
target_include_directories(${LIB_NAME} PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
)

# add doc
add_doxygen(${LIB_NAME})

# export library
install(TARGETS ${LIB_NAME} DESTINATION lib)

# export public headers
set(HEADERS
    Break.h
    BreakFactory.h
)
install(FILES ${HEADERS} DESTINATION include)

# set test name
set(TEST_NAME unit_test)

# compile an executable file (exe) for unit test of source files
add_executable(${TEST_NAME}
    ${SRC_CPP}
    ${TEST_CPP}
)

# add google test libraries for unit test
target_link_libraries(${TEST_NAME}
    gtest_main
    gmock_main
)

# add unit tests to ctest command
add_test(
  NAME
    ${TEST_NAME}
  COMMAND
    ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}/${TEST_NAME}
)
