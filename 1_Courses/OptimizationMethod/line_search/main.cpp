#include <iostream>
#include "ExactSearcher.h"

using namespace std;

double test(double x){
    return x+1;
}

int main() {
    ExactSearcher exactSearcher;
    exactSearcher.GoldenSection(1, test);

    exactSearcher.getFunctionPointer(test);
    exactSearcher.testPointer(1);

    return 0;
}
