// include libs
#include <iostream>

// include headers
#include "CoordinateConvertor.h"

int main() {
    CoordinateConvertor convertor;
    convertor.getLLAParas(31.036, 121.455, 0);
    convertor.Draw(31.036321, 121.455899, 100);

    std::cout << std::endl << "Program proceeded with success, quitting now..." << std::endl;
    return 0;
}
