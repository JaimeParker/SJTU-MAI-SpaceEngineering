cmake_minimum_required(VERSION 3.23)
project(line_search)

set(CMAKE_CXX_STANDARD 14)

add_executable(
        line_search main.cpp
        ExactSearcher.cc
        ExactSearcher.h)
