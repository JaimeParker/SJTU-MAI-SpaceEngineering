# Mosek Config

## license

* https://www.mosek.com/products/academic-licenses/
* 选择Personal Academic License
* 根据`edu`邮件，接收邮件中的license附件
* 将该附件根据不同操作系统放置到指定位置

> The license file should be placed inside a folder called "mosek"  under the user's home directory ($HOME/mosek/mosek.lic or  %USERPROFILE%\mosek\mosek.lic). In most typical cases that will be:
>
> ```
> /home/YOUR_USER_NAME/mosek/mosek.lic      (Linux)        
> /Users/YOUR_USER_NAME/mosek/mosek.lic     (OSX)        
> C:\Users\YOUR_USER_NAME\mosek\mosek.lic   (Windows)
> ```

`cvx`是用来在mosek与MATLAB之间数据转换的，或者是问题转换的（可以选择不用）：http://cvxr.com/cvx/mosek/；

## c++ config

### 1. install

1. Go to `<MSKHOME>/mosek/10.0/tools/platform/<PLATFORM>/src/fusion_cxx`
2. Run `make install` (Linux, macOS) or `nmake install` (Windows)

Linux上`make install`（有`build-essential`和`gcc`），Windows上看自己编译器，不一定是`nmake`；

### 2. use cmake

（也可以不使用cmake去构建程序）

构建一个`FindMOSEK.cmake`，参考https://gitlab.vci.rwth-aachen.de:9000/CoMISo/CoMISo/-/blob/master/cmake/FindMOSEK.cmake；

```cmake
# - Try to find MOSEK

#  MOSEK_BASE - base path to the library

# Once done this will define
#  MOSEK_FOUND - System has Mosek
#  MOSEK_INCLUDE_DIRS - The Mosek include directories
#  MOSEK_LIBRARIES - The libraries needed to use Mosek
#  MOSEK_LIBRARY_DIR - The Mosek library dicrectory

set (MOSEK_BASE "/home/hazyparker/Apps/mosek/10.0")

if (MOSEK_INCLUDE_DIR)
    # in cache already
    set(MOSEK_FOUND TRUE)
    set(MOSEK_INCLUDE_DIRS "${MOSEK_INCLUDE_DIR}" )
    set(MOSEK_LIBRARIES "${MOSEK_LIBRARY};${MOSEK_CXX_LIBRARY}" )
else (MOSEK_INCLUDE_DIR)

    find_path(MOSEK_INCLUDE_DIR
            NAMES mosek.h
            PATHS "$ENV{MOSEK_DIR}/tools/platform/linux64x86/h"
            "${MOSEK_BASE}/tools/platform/linux64x86/h"
            )
            
    find_path(MOSEK_LIBRARY_DIR
            NAMES libmosek64.dylib
            PATHS "$ENV{MOSEK_DIR}/tools/platform/linux64x86/bin"
            "${MOSEK_BASE}/tools/platform/linux64x86/bin"
            )

    find_library(MOSEK_LIBRARY
            NAMES mosek64

            PATHS "$ENV{MOSEK_DIR}/tools/platform/linux64x86/bin"
            "${MOSEK_BASE}/tools/platform/linux64x86/bin"
            )

    find_library(MOSEK_CXX_LIBRARY
            NAMES fusion64

            PATHS "$ENV{MOSEK_DIR}/tools/platform/linux64x86/bin"
            "${MOSEK_BASE}/tools/platform/linux64x86/bin"
            )

    # Binary dir for DLLs
    find_path(MOSEK_BIN_DIR
            NAMES "mosek.dll"
            PATHS "$ENV{MOSEK_DIR}/tools/platform/linux64x86/bin"
            "${MOSEK_BASE}/tools/platform/linux64x86/bin"

            DOC "Directory containing the MOSEK DLLs"
            )

    set(MOSEK_INCLUDE_DIRS "${MOSEK_INCLUDE_DIR}" )
    set(MOSEK_LIBRARIES "${MOSEK_LIBRARY};${MOSEK_CXX_LIBRARY}" )

    include(FindPackageHandleStandardArgs)
    # handle the QUIETLY and REQUIRED arguments and set LIBCPLEX_FOUND to TRUE
    # if all listed variables are TRUE
    find_package_handle_standard_args(MOSEK  DEFAULT_MSG
            MOSEK_LIBRARY MOSEK_CXX_LIBRARY MOSEK_INCLUDE_DIR)

    mark_as_advanced(MOSEK_INCLUDE_DIR MOSEK_LIBRARY MOSEK_CXX_LIBRARY MOSEK_BIN_DIR MOSEK_LIBRARY_DIR)

endif(MOSEK_INCLUDE_DIR)
```

按实际情况替换里面的`MOSEK_BASE`和`linux64x86`；

将该`FindXXX.cmake`放到`${PROJECT_SOURCE_DIR}/cmake_modules)`下；

### 3. cmakelist

```cmake
cmake_minimum_required(VERSION 3.23)
project(PROJECT)

set(CMAKE_CXX_STANDARD 14)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake_modules)

find_package(MOSEK)
include_directories(${MOSEK_INCLUDE_DIRS})
target_link_libraries(PROJECT ${MOSEK_LIBRARIES})
```

## python config

`pip install Mosek`

```python
import mosek
```

