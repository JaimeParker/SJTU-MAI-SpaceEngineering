cmake_minimum_required(VERSION 3.23)
project(homework2)

set(CMAKE_CXX_STANDARD 14)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake_modules)

find_package(MOSEK)
include_directories(${MOSEK_INCLUDE_DIRS})

add_executable(homework2 main.cpp)
target_link_libraries(homework2 ${MOSEK_LIBRARIES})