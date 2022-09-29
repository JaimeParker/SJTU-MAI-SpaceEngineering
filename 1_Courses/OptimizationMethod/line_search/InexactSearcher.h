//
// Created by hazy parker on 22-9-29.
//

#ifndef LINE_SEARCH_INEXACTSEARCHER_H
#define LINE_SEARCH_INEXACTSEARCHER_H


class InexactSearcher {
private:
    double (*function)(double);  // function pointer
public:
    // constructor function
    InexactSearcher();

    // get function pointer
    void getFunctionPointer(double (*func)(double));

    // method using wolfe criterion
    double WolfeSearcher();
};


#endif //LINE_SEARCH_INEXACTSEARCHER_H
