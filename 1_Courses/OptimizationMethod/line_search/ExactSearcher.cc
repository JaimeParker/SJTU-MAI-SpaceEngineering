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
    middle = 0;
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

void ExactSearcher::Init3Interval(double left_interval, double middle_interval,
                                  double right_interval) {
    left = left_interval;
    middle = middle_interval;
    right = right_interval;

    if (!(left <= middle && middle <= right) ||
    !(function(left) >= function(middle) && function(right) >= function(middle))) {
        cout << "Bad input It's not qualified for Quadratic Interpolation!" << endl;
        exit(100);
    }
}

void ExactSearcher::InitPrecision(double accuracy) {
    precision = accuracy;
}

double ExactSearcher::QuadraticInterpolation(enum ShowType type) {
    // define vector to restore data
    vector<vector<double>> interval_list;
    vector<double> list;  // used for store the data temporarily

    // transfer data
    double s0 = left;
    double s1 = middle;
    double s2 = right;
    double phi0 = function(s0);
    double phi1 = function(s1);
    double phi2 = function(s2);

    // set allowable error
    double error = 0.0001;

    //
    double h = (s2 - s0) / 2;
    double h_bar = (4*phi1 - 3*phi0 - phi2) * h / (2 * (2*phi1 - phi0 - phi2));
    double s_bar, phi_bar, diff;
    int iter = 0;

    std::chrono::steady_clock::time_point t1 = std::chrono::steady_clock::now();
    while (true){
        iter += 1;
        // write data to vector_list if user request SHOW type
        if (type == TYPE_SHOW){
            list.push_back(s0);
            list.push_back(s1);
            list.push_back(s2);
            interval_list.push_back(list);
            list.clear();
        }

        if (abs(s0 - s2) < error) break;
        diff = abs(s0 - s2);
        h = (s2 - s0) / 2.0;
        h_bar = (4*phi1 - 3*phi0 - phi2) * h / (2 * (2*phi1 - phi0 - phi2));
        s_bar = s0 + h_bar;
        phi_bar = function(s_bar);
        if (phi1 <= phi_bar){
            // step 4
            if (s1 <= s_bar) {
                s2 = s_bar;
                phi2 = phi_bar;
            } else {
                s0 = s_bar;
                phi0 = phi_bar;
            }
        }
        else {
            // step 3
            if (s1 <= s_bar){
                s2 = s1;
                s1 = s_bar;
                phi2 = phi1;
                phi1 = phi_bar;
            } else {
                s0 = s1;
                s1 = s_bar;
                phi0 = phi1;
                phi1 = phi_bar;
            }
        }
    }

    // calculate time used
    std::chrono::steady_clock::time_point t2 = std::chrono::steady_clock::now();
    std::chrono::duration<double> time_used = std::chrono::duration_cast<
            std::chrono::duration<double>>(t2 - t1);
    std::cout << "time used: " << time_used.count() << "s" << std::endl;

    cout << "the root is: " << s1 << endl;

    // show the data processing
    if (type == TYPE_SHOW) {
        cout << endl << "Presenting the interval processing history:" << endl;
        for (int j = 0; j <= iter; j++){
            for (int k = 0; k <= 2; k++){
                cout << setw(8) << interval_list[j][k] << ", ";
            }
            cout << endl;
        }
    }

    return 0;
}

void ExactSearcher::AutoSearchInterval() {
    double alpha0 = 1;
    double h0 = 0.1;
    int k = 0;
    double phi0 = function(alpha0);

    double alpha_k = alpha0;
    double hk = h0;
    double phi_k = phi0, phi_k1;
    double alpha;

    double alpha1 = alpha0 + h0;
    while (true) {
        // running step 2 now
        phi_k1 = function(alpha_k + hk);
        k += 1;
        cout << "iter: " << k << endl;
        if (phi_k1 < phi_k) {
            phi_k = phi_k1;
            alpha = alpha_k;
            alpha_k += hk;
            hk = hk * 2;
        } else {
            if (k == 0) {
                hk = h0;
                alpha = alpha1;
                alpha1 = alpha0;
                k = 1;
            } else break;
        }


    }

    cout << alpha <<  ", " <<alpha_k << endl;

}


