//
// Created by hazyparker on 22-9-23.
//

#include <iostream>

#include "ExactSearcher.h"

double ExactSearcher::GoldenSection(double x, double (*func)(double)) {
    double root = 0;

    root = func(x) + 1;

    std::cout << root;
    return root;
}

ExactSearcher::ExactSearcher() {
    // set function pointer as null pointer in case of error
    function = nullptr;
    d_function = nullptr;

    // define max iteration time
    max_iter = 100;

    // define precision
    precision = 0.001;
}

void ExactSearcher::getFunctionPointer(double (*func)(double)) {
    function = func;
}

void ExactSearcher::testPointer(double x) {
    double y = function(x);
}

void ExactSearcher::getNewMaxIteration(int iter) {
    max_iter = iter;
}
