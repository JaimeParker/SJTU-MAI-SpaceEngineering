//
// Created by hazy parker on 22-9-29.
//

#include "InexactSearcher.h"

InexactSearcher::InexactSearcher() {
    // Init private members
    function  = nullptr;
    d_function = nullptr;

    init_value = 0.0;
}

void InexactSearcher::getFunctionPointer(double (*func)(double)) {
    function = func;
}

void InexactSearcher::getDerivativeFunctionPointer(double (*func)(double)) {
    d_function = func;
}

void InexactSearcher::getInitValue(double init) {
    init_value = init;
}

double InexactSearcher::WolfeSearcher() {
    double x0 = init_value;

    return 0;
}


