// include libs
#include <iostream>

// include headers
#include "CoordinateConvertor.h"

int main() {
    CoordinateConvertor convertor;
    double d2r = 3.1415926/180;
    convertor.getLLAParas(31.036*d2r, 121.455*d2r, 0);
    convertor.Draw(31.036321*d2r, 121.455899*d2r, 100);

    std::cout << std::endl << "Program proceeded with success, quitting now..." << std::endl;
    return 0;
}
