//
// Created by hazy parker on 22-9-30.
//

/**
 * this program is designed for coordinate conversion
 * from LLA to ECEF and ECI coordinates
 * and a relative ENU coordinate transfer
 */

#ifndef HOMEWORK2_COORDINATECONVERTOR_H
#define HOMEWORK2_COORDINATECONVERTOR_H

#include <tuple>

typedef std::tuple<double, double, double> Coordinate;

class CoordinateConvertor {
private:
    // define earth parameter, referring from
    // https://nssdc.gsfc.nasa.gov/planetary/factsheet/earthfact.html
    // be advised, the units here is kilometers
    const double equatorial_radius = 6378.137;
    const double polar_radius = 6356.752;
    const double flattening_factor = 0.0033528107;

    // define the LLA coordinates by user
    double latitude;
    double longitude;
    double height;

public:
    // define constructor function
    CoordinateConvertor();

    /**
     * get LLA parameters for conversion
     * @param phi latitude, in decimal degrees, do not use minutes and seconds format
     * @param lambda longitude, in decimal degrees, do not use minutes and seconds format
     * @param h height, in meters as unit
     */
    void getLLAParas(double phi, double lambda, double h);

    // define transfer from LLA to ECEF
    Coordinate LLA2ECEF(double phi, double lambda, double h) const;

    Coordinate LLA2ECEFforA() const;

    // define ENU transfer
    Coordinate ECEF2ENU(double phi_p, double lambda_p, double h_p) const;

    // draw figure
    void Draw(double phi_p, double lambda_p, double h_p) const;

};


#endif //HOMEWORK2_COORDINATECONVERTOR_H
