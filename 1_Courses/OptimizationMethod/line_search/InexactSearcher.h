//
// Created by hazy parker on 22-9-29.
//

#ifndef LINE_SEARCH_INEXACTSEARCHER_H
#define LINE_SEARCH_INEXACTSEARCHER_H


class InexactSearcher {
private:
    double (*function)(double);  // function pointer
    double (*d_function)(double);  // derivative pointer

    double init_value;  // search start
public:
    // constructor function
    InexactSearcher();

    // get function pointer
    void getFunctionPointer(double (*func)(double));

    // get derivative pointer
    void getDerivativeFunctionPointer(double (*func)(double));

    // get start point
    void getInitValue(double init);

    // method using wolfe criterion
    double WolfeSearcher();
};


#endif //LINE_SEARCH_INEXACTSEARCHER_H
