//
// Created by root on 16-3-5.
//

#ifndef ALGLIB_PARAMETERREADER_HPP
#define ALGLIB_PARAMETERREADER_HPP

#include "types.hpp"
#include <boost/tuple/tuple.hpp>
#include <string>

boost::tuple<real_2d_array, real_1d_array, real_1d_array, real_1d_array>
        parameterReader(const std::string& filePath);

#endif //ALGLIB_PARAMETERREADER_HPP
