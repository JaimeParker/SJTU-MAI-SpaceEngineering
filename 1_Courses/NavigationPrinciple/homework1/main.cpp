//
// Created by hazyparker on 22-9-19.
//

// include libs
#include <iostream>

// include headers
#include "TimeConversion.h"

// set namespace
using namespace std;

int main() {
    TimeConversion timeConversion(2000, 2, 29, 9, 59, 45);
    timeConversion.ShowAllTime();
    return 0;
}
