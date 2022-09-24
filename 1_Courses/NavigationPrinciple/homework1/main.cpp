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
    TimeConversion timeConversion3(2022, 9, 24, 16, 35, 5);
    timeConversion3.ShowAllTime();
    TimeConversion timeConversion2(2012, 3, 1, 7, 0, 0);
    timeConversion2.ShowAllTime();

    return 0;
}
