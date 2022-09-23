//
// Created by hazyparker on 22-9-23.
//

#ifndef LINE_SEARCH_EXACTSEARCHER_H
#define LINE_SEARCH_EXACTSEARCHER_H


class ExactSearcher {
private:
    // create function's pointer
    double (*function)(double);

    // create function derivative's pointer
    double (*d_function)(double);

    // define precision
    double precision;

    // define max iteration time
    double max_iter;

public:
    // constructor function
    ExactSearcher();

    // set function pointer
    void getFunctionPointer(double (*func)(double));

    // set
    void getNewMaxIteration(int iter);

    double GoldenSection(double x, double (*func)(double));

    void testPointer(double x);
};


#endif //LINE_SEARCH_EXACTSEARCHER_H
