//
// Created by hazy parker on 22-9-23.
//

#ifndef LINE_SEARCH_EXACTSEARCHER_H
#define LINE_SEARCH_EXACTSEARCHER_H

enum ShowType {TYPE_HIDE = 0, TYPE_SHOW = 1};

class ExactSearcher {
private:
    // create function's pointer
    double (*function)(double);

    // create function derivative's pointer
    double (*d_function)(double);

    // define precision
    double precision;

    // define max iteration time
    int max_iter;

    // define intervals
    double left;
    double right;
    double middle;

public:
    // constructor function
    ExactSearcher();

    // set function pointer
    void getFunctionPointer(double (*func)(double));

    /**
     * allow user to update the maximum iteration time
     * @param iter iteration time
     */
    void getNewMaxIteration(int iter);

    /**
     * Golden Section method for line search;
     * actually I'm using 0.618 method here;
     * @param func  pointer to the function defined in main.cpp
     * @return the estimated root
     */
    double GoldenSection(enum ShowType type = TYPE_HIDE);

    double QuadraticInterpolation(enum ShowType type = TYPE_HIDE);

    // allow user to init the interval
    void InitOriginalInterval(double left_interval, double right_interval);

    // allow user to init the 3 element interval
    void Init3Interval(double left_interval, double middle_interval,
                       double right_interval);

    // set precision
    void InitPrecision(double accuracy);

    void AutoSearchInterval();

};


#endif //LINE_SEARCH_EXACTSEARCHER_H
