cmake_minimum_required(VERSION 3.23)
project(homework2)

set(CMAKE_CXX_STANDARD 14)

# add eigen3 dependency
find_package(Eigen3 REQUIRED)

find_package(OpenCV REQUIRED)
include_directories(OpenCV_INCLUDE_DIRS)

add_executable(homework2
        main.cpp
        CoordinateConvertor.cc
        CoordinateConvertor.h)

target_link_libraries(homework2
        Eigen3::Eigen
        ${OpenCV_LIBS})
