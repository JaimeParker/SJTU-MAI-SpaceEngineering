cmake_minimum_required(VERSION 3.23)
project(line_search)

set(CMAKE_CXX_STANDARD 14)

find_package(Ceres REQUIRED)

add_executable(
        line_search main.cpp
        ExactSearcher.cc
        ExactSearcher.h
        InexactSearcher.cc
        InexactSearcher.h)

add_executable(testCeres useCeres.cc)
target_link_libraries(testCeres PRIVATE Ceres::ceres)
