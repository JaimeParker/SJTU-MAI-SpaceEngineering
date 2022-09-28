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
    searcher1.GoldenSection(TYPE_HIDE);

    // searcher1.AutoSearchInterval();

    ExactSearcher searcher2;
    searcher2.getFunctionPointer(function1);
    searcher2.Init3Interval(0, 0.5, 1);
    searcher2.QuadraticInterpolation(TYPE_HIDE);


    cout << "program proceed with success, quitting now" << endl;
    return 0;
}
