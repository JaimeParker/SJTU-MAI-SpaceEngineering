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
    TimeConversion timeConversion(2022, 9, 19, 10-8, 0, 0.0);
    timeConversion.ShowAllTime();
    return 0;
}
