# Line Search Test

## Exact Search

### Golden Section(0.618 Method)

```cpp
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
```

for $f(x)=x^2-\sin{x}$, initial $x\in [0,1]$, precision = $10^{-5}$

```shell
time used: 3.4794e-05s
estimated root is: 0.450182

Presenting the interval processing history:
       0,    0.382,    0.618,        1, 
       0, 0.236076,    0.382,    0.618, 
0.236076,    0.382, 0.472105,    0.618, 
   0.382, 0.472105, 0.527848,    0.618, 
   0.382, 0.437714, 0.472105, 0.527848, 
   0.382,  0.41642, 0.437714, 0.472105, 
 0.41642, 0.437714, 0.450833, 0.472105, 
0.437714, 0.450833, 0.458968, 0.472105, 
0.437714, 0.445833, 0.450833, 0.458968, 
0.445833, 0.450833,  0.45395, 0.458968, 
0.445833, 0.448934, 0.450833,  0.45395, 
0.448934, 0.450833, 0.452034,  0.45395, 
0.448934, 0.450118, 0.450833, 0.452034, 
0.448934, 0.449659, 0.450118, 0.450833, 
0.449659, 0.450118, 0.450385, 0.450833, 
0.449659, 0.449937, 0.450118, 0.450385, 
0.449937, 0.450118, 0.450214, 0.450385, 
0.450118, 0.450214, 0.450283, 0.450385, 
0.450118, 0.450181, 0.450214, 0.450283, 
0.450118, 0.450154, 0.450181, 0.450214, 
0.450154, 0.450181, 0.450191, 0.450214, 
0.450154, 0.450168, 0.450181, 0.450191, 
0.450168, 0.450181, 0.450182, 0.450191, 
0.450181, 0.450182, 0.450187, 0.450191, 
```

### Quadratic Interpolation

```cpp
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
```

for $f(x)=x^2-\sin{x}$, initial $x\in [0,1]$, precision = $10^{-5}$

```shell
time used: 6.366e-06s
the root is: 0.435806

Presenting the interval processing history:
       0,      0.5,        1, 
     0.5, 0.435806,        1, 
     0.5, 0.435806, 0.626772, 
     0.5, 0.435806, 0.535972, 
     0.5, 0.435806,  0.51332, 
     0.5, 0.435806,  0.50583, 
     0.5, 0.435806, 0.502741, 
     0.5, 0.435806, 0.501331, 
     0.5, 0.435806, 0.500656, 
     0.5, 0.435806, 0.500326, 
     0.5, 0.435806, 0.500162, 
     0.5, 0.435806, 0.500081, 
```

## Inexact Search

## Ceres Solver

for $f(x)=x^2-\sin{x}$, initial $x=0.5$

```cpp
struct CostFunctor {
    template <typename T>
    bool operator()(const T* const x, T* residual) const {
        residual[0] = 10.0 - x[0];
        residual[0] = x[0] + x[0] + cos(x[0]);
        return true;
    }
};

int main(int argc, char** argv) {
    google::InitGoogleLogging(argv[0]);
    // The variable to solve for with its initial value. It will be
    // mutated in place by the solver.
    double x = 0.5;
    const double initial_x = x;
    // Build the problem.
    Problem problem;
    // Set up the only cost function (also known as residual). This uses
    // auto-differentiation to obtain the derivative (jacobian).
    CostFunction* cost_function =
            new AutoDiffCostFunction<CostFunctor, 1, 1>(new CostFunctor);
    problem.AddResidualBlock(cost_function, nullptr, &x);
    // Run the solver!
    Solver::Options options;
    options.minimizer_progress_to_stdout = true;
    Solver::Summary summary;
    Solve(options, &problem, &summary);
    std::cout << summary.BriefReport() << "\n";
    std::cout << "x : " << initial_x << " -> " << x << "\n";
    return 0;
}
```

```shell
iter      cost      cost_change  |gradient|   |step|    tr_ratio  tr_radius  ls_iter  iter_time  total_time
   0  1.762658e+00    0.00e+00    2.86e+00   0.00e+00   0.00e+00  1.00e+04        0    1.98e-05    7.68e-05
   1  2.644575e-01    1.50e+00    1.94e+00   0.00e+00   8.50e-01  1.52e+04        1    3.60e-05    1.48e-04
   2  4.393691e-04    2.64e-01    7.25e-02   2.72e-01   9.98e-01  4.57e+04        1    9.06e-06    1.66e-04
   3  2.211363e-09    4.39e-04    1.62e-04   1.21e-02   1.00e+00  1.37e+05        1    6.91e-06    1.78e-04
   4  3.372629e-19    2.21e-09    2.00e-09   2.73e-05   1.00e+00  4.11e+05        1    5.96e-06    1.89e-04
Ceres Solver Report: Iterations: 5, Initial cost: 1.762658e+00, Final cost: 3.372629e-19, Termination: CONVERGENCE
x : 0.5 -> -0.450184
```

