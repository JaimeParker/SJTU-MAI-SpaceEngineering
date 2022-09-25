//
// Created by hazy parker on 22-9-23.
//

#include <iostream>
#include <chrono>
#include <vector>
#include <iomanip>

#include "ExactSearcher.h"

using namespace std;

ExactSearcher::ExactSearcher() {
    // set function pointer as null pointer in case of error
    function = nullptr;
    d_function = nullptr;

    // define max iteration time
    max_iter = 100;

    // define precision
    precision = 0.0001;

    // init the interval, can be revised by user
    left = -10;
    right = 10;
}

void ExactSearcher::getFunctionPointer(double (*func)(double)) {
    function = func;
}

void ExactSearcher::getNewMaxIteration(int iter) {
    max_iter = iter;
}

double ExactSearcher::GoldenSection(enum ShowType type) {
    // define vector to restore data
    vector<vector<double>> interval_list;
    vector<double> list;  // used for store the data temporarily

    // give root a initial value
    double root;

    // init the first new interval
    double p0 = left + 0.382 * (right - left);
    double q0 = left + 0.618 * (right - left);

    // name the value of left interval p0,
    // and the value of right interval q0
    double phi_p0 = function(p0);
    double phi_q0 = function(q0);

    // set iteration time
    int i = 0;

    // according to step 3, the breaking operation is
    // connected with relationship between error and precision
    double phi_pi = phi_p0, pi = p0;
    double phi_qi = phi_q0, qi = q0;
    double ai = left, bi = right;

    std::chrono::steady_clock::time_point t1 = std::chrono::steady_clock::now();
    while (true) {
        // write data to vector_list if user request SHOW type
        if (type == TYPE_SHOW){
            list.push_back(ai);
            list.push_back(pi);
            list.push_back(qi);
            list.push_back(bi);
            interval_list.push_back(list);
            list.clear();
        }

        // if phi_qi <= phi_qi, turns to step 2
        if (phi_pi <= phi_qi) {
            // if the interval is less than precision
            // break and send pi to the root
            if (std::abs(qi - ai) <= precision) {
                root = pi;
                std::cout << "root found!" << std::endl;
                break;
            }
            // else, commencing the interval operation
            ai = ai;
            bi = qi;
            phi_qi = phi_pi;  // phi_qi is smaller, the possible section changes
            qi = pi;
            pi = ai + 0.382 * (bi - ai);
            phi_pi = function(pi);

            // update the iteration
            i += 1;
            if (i > max_iter) {
                std::cout << "ERROR! program has reached the max_iter! Consider revising the "
                             "max_iter or polish your algorithm" << std::endl;
                exit(100);
            }
        }
        // if phi_qi > phi_qi, turns to step 3
        else {
            // if the interval is less than precision
            // break and send pi to the root
            if (std::abs(bi - pi) <= precision) {
                root = qi;
                std::cout << "root found!" << std::endl;
                break;
            }
            // else, commencing the interval operation
            ai = pi;
            bi = bi;
            phi_pi = phi_qi; // phi_qi is smaller, the possible section changes
            pi = qi;
            qi = ai + 0.618 * (bi - ai);
            phi_qi = function(qi);

            // update the iteration
            i += 1;
            if (i > max_iter) {
                std::cout << "ERROR! program has reached the max_iter! Consider revising the "
                             "max_iter or polish your algorithm" << std::endl;
                exit(100);
            }
        }

    }

    // calculate time used
    std::chrono::steady_clock::time_point t2 = std::chrono::steady_clock::now();
    std::chrono::duration<double> time_used = std::chrono::duration_cast<
            std::chrono::duration<double>>(t2 - t1);
    std::cout << "time used: " << time_used.count() << "s" << std::endl;

    std::cout << "estimated root is: " << root << std::endl;

    // show the data processing
    if (type == TYPE_SHOW) {
        cout << endl << "Presenting the interval processing history:" << endl;
        for (int j = 0; j <= i; j++){
            for (int k = 0; k <= 3; k++){
                cout << setw(8) << interval_list[j][k] << ", ";
            }
            cout << endl;
        }
    }

    return root;
}

void ExactSearcher::InitOriginalInterval(double left_interval,
                                         double right_interval) {
    // give the priority of setting initial interval to user
    left = left_interval;
    right = right_interval;
}

void ExactSearcher::InitPrecision(double accuracy) {
    precision = accuracy;
}
