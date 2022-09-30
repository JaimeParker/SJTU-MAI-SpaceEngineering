#include <iostream>
#include <cmath>
#include "ExactSearcher.h"

using namespace std;

double function1(double x) {
    return x * x - sin(x);
}

double function2(double x) {
    return exp(-x) + x * x;
}

double function3(double x){
    return pow(x, 4) + pow(x, 2) + 4;
}

int main() {
    ExactSearcher searcher1;
    searcher1.getFunctionPointer(function1);
    searcher1.InitPrecision(0.00001);
    searcher1.getNewMaxIteration(100);
    searcher1.InitOriginalInterval(0, 1);
    searcher1.GoldenSection(TYPE_SHOW);

    cout << endl;
    // searcher1.AutoSearchInterval();

    ExactSearcher searcher2;
    searcher2.getFunctionPointer(function1);
    searcher2.Init3Interval(0, 0.5, 1);
    searcher2.QuadraticInterpolation(TYPE_SHOW);

    cout << endl;

    ExactSearcher searcher3;
    searcher3.getFunctionPointer(function2);
    searcher3.InitOriginalInterval(0, 2);
    searcher3.GoldenSection();
    searcher3.Init3Interval(0, 0.5, 1);
    searcher3.QuadraticInterpolation();

    cout << endl;

    ExactSearcher searcher4;
    searcher4.getFunctionPointer(function3);
    searcher4.InitOriginalInterval(-1, 1);
    searcher4.Init3Interval(-1, 0, 1);
    searcher4.GoldenSection();
    searcher4.QuadraticInterpolation();

    cout << "program proceed with success, quitting now" << endl;
    return 0;
}
