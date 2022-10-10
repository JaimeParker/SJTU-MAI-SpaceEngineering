//
// Created by hazy parker on 22-9-30.
//

#include "CoordinateConvertor.h"
#include <iostream>
#include <cmath>
#include <Eigen/Core>
#include <opencv4/opencv2/opencv.hpp>

using namespace std;

CoordinateConvertor::CoordinateConvertor() {
    // set the default position as
    // National Flag of People's Republic of China
    latitude = 39.913254;
    longitude = 116.403927;
    height = 50;
}

void CoordinateConvertor::getLLAParas(double phi, double lambda, double h) {
    latitude = phi;
    longitude = lambda;
    height = h;
}

Coordinate CoordinateConvertor::LLA2ECEF(double phi, double lambda, double h) const {
    // define earth parameters
    double a = equatorial_radius * 1000;  // unit converting here, to meters
    double b = polar_radius * 1000;  // unit converting here, to meters
    double e2 = 1 - (b*b) / (a*a);

    // define ECEF parameters;
    double x, y, z;

    // calculate
    double n = a / sqrt(1 - e2 * sin(phi) * sin(phi));
    x = (n + h) * cos(phi) * cos(lambda);
    y = (n + h) * cos(phi) * sin(lambda);
    z = ((1 - e2) * n + h) * sin(phi);

    cout << x << ", " << y << ", " << z << endl;

    Coordinate pos;
    get<0>(pos) = x;
    get<1>(pos) = y;
    get<2>(pos) = z;
    return pos;
}

Coordinate CoordinateConvertor::ECEF2ENU(double phi_p, double lambda_p, double h_p) const {
    double phi_r = latitude;
    double lambda_r = longitude;
    double h_r = height;

    Coordinate ECEF_r = LLA2ECEF(phi_r, lambda_r, h_r);
    Coordinate ECEF_p = LLA2ECEF(phi_p, lambda_p, h_p);

    Eigen::Matrix<double, 3, 3> matrix_33;
    Eigen::Matrix<double, 3, 1> matrix_right;
    Eigen::Matrix<double, 3, 1> matrix_left;

    matrix_33(0, 0) = -sin(lambda_r);
    matrix_33(0, 1) = cos(lambda_r);
    matrix_33(0, 2) = 0;
    matrix_33(1, 0) = -sin(phi_r) * cos(lambda_r);
    matrix_33(1, 1) = -sin(phi_r) * sin(lambda_r);
    matrix_33(1, 2) = cos(phi_r);
    matrix_33(2, 0) = cos(phi_r) * cos(lambda_r);
    matrix_33(2, 1) = cos(phi_r) * sin(lambda_r);
    matrix_33(2, 2) = sin(phi_r);

    matrix_right(0, 0) = get<0>(ECEF_p) - get<0>(ECEF_r);
    matrix_right(1, 0) = get<1>(ECEF_p) - get<1>(ECEF_r);
    matrix_right(2, 0) = get<2>(ECEF_p) - get<2>(ECEF_r);

    matrix_left = matrix_33 * matrix_right;

    Coordinate vector;
    get<0>(vector) = matrix_left(0, 0);
    get<1>(vector) = matrix_left(1, 0);
    get<2>(vector) = matrix_left(2, 0);

    cout << "ENU coordinates from A to B:" << endl;
    cout << "x: " << matrix_left(0, 0) << ", "
        << "y: " << matrix_left(1, 0) << ", "
        << "z: " << matrix_left(2, 0) << endl;

    return vector;
}

Coordinate CoordinateConvertor::LLA2ECEFforA() const {
    // define earth parameters
    double a = equatorial_radius * 1000;  // unit converting here, to meters
    double b = polar_radius * 1000;  // unit converting here, to meters
    double e2 = 1 - (b*b) / (a*a);
    double phi = latitude;
    double lambda = longitude;
    double h = height;

    // define ECEF parameters;
    double x, y, z;

    // calculate
    double n = a / sqrt(1 - e2 * sin(phi) * sin(phi));
    x = (n + h) * cos(phi) * cos(lambda);
    y = (n + h) * cos(phi) * sin(lambda);
    z = ((1 - e2) * n + h) * sin(phi);

    cout << x << ", " << y << ", " << z << endl;

    Coordinate pos;
    get<0>(pos) = x;
    get<1>(pos) = y;
    get<2>(pos) = z;
    return pos;
}

void CoordinateConvertor::Draw(double phi_p, double lambda_p, double h_p) const {
    Coordinate vector = ECEF2ENU(phi_p, lambda_p, h_p);
    double E = get<0>(vector);
    double N = get<1>(vector);
    double U = get<2>(vector);

    double az = atan(E / N);
    double el = asin(U / sqrt(E*E + N*N + U*U));

    cout << "az is " << az / 3.14 * 180 << " degrees" << endl;
    cout << "el is " << el / 3.14 * 180 << " degrees" << endl;

    cv::Mat img;
    img = cv::Mat::zeros(800, 800, CV_8UC3);
    img = cv::Scalar(255, 255, 255);

    cv::Point center;
    center.x  = 400;
    center.y = 400;
    cv::Scalar color = (0, 0, 0);
    cv::circle(img, center, 100, color);
    cv::circle(img, center, 200, color);
    cv::circle(img, center, 300, color);

    cv::line(img, {100, 400}, {700, 400}, color);
    cv::line(img, {400, 100}, {400, 700}, color);

    double length = 300 - abs(el) / 3.1415 * 180 / 90 * 300;
    double length_n = length * cos(3.1415/2 - az);
    double length_e = length * sin(3.1415/2 - az);
    cv::line(img, {400, 400}, {int(length_e) + 400, int(length_n) + 400}, {0, 0, 255}, 2);

    cv::namedWindow("img", cv::WINDOW_NORMAL);
    cv::imshow("img", img);
    //cv::imwrite("../sky map.jpg", img);
    cv::waitKey(0);
}
