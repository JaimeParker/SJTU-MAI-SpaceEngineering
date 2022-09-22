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
    TimeConversion timeConversion1(2022, 9, 19, 10, 0, 0.0);
    timeConversion1.ShowAllTime();
    TimeConversion timeConversion2(2000, 3, 1, 2, 0, 0);
    timeConversion2.ShowAllTime();
    return 0;
}
