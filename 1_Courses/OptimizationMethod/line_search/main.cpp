#include <iostream>
#include <cmath>
#include "ExactSearcher.h"

using namespace std;

double function1(double x) {
    return x * x - sin(x);
}

int main() {
    ExactSearcher searcher1;
    searcher1.getFunctionPointer(function1);
    searcher1.InitPrecision(0.00001);
    searcher1.getNewMaxIteration(100);
    searcher1.InitOriginalInterval(0, 1);
    searcher1.GoldenSection(TYPE_SHOW);


    cout << "program proceed with success, quitting now" << endl;
    return 0;
}