//
// Created by hazy parker on 22-9-29.
//

#include "InexactSearcher.h"

InexactSearcher::InexactSearcher() {
    // Init private members
    function  = nullptr;

}

void InexactSearcher::getFunctionPointer(double (*func)(double)) {
    function = func;
}

double InexactSearcher::WolfeSearcher() {


    return 0;
}
