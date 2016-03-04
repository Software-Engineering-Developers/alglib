#! /bin/bash -e
# $Id$
# -----------------------------------------------------------------------------
# CppAD: C++ Algorithmic Differentiation: Copyright (C) 2003-13 Bradley M. Bell
#
# CppAD is distributed under multiple licenses. This distribution is under
# the terms of the 
#                     Eclipse Public License Version 1.0.
#
# A copy of this license is included in the COPYING file of this distribution.
# Please visit http://www.coin-or.org/CppAD/ for information on other licenses.
# -----------------------------------------------------------------------------
# Eigen generates lots of warnings if -Wshadow is set of compile; e.g.,
# the first warning generated by this script is:
#
# warning: declaration of ‘value’ shadows a member of 'this' [-Wshadow]
#     explicit variable_if_dynamic(T value) : m_value(value) {}
#                                           ^
# ------------------------------------------------------------------------------
# bash function that echos and executes a command
echo_eval() {
	echo $*
	eval $*
}
# -----------------------------------------------
if [ ! -e build ]
then
	mkdir build
fi
cd build
echo "$0"
name=`echo $0 | sed -e 's|.*/||' -e 's|\..*||'`
#
cat << EOF > $name.cpp
# include <iostream>
# include <Eigen/Core>

int main() {
	using Eigen::Matrix;
	using Eigen::Dynamic;
	Matrix<double, Dynamic, Dynamic> A(1,1);
	A(0,0) = 6.0;

	if( A(0,0) != 6.0 )
	{	std::cout << "$name: Error" << std::endl;
		return 1;
	}
	std::cout << "$name: OK" << std::endl;
	return 0;
}
EOF
if [ -e "$name" ]
then
	echo_eval rm $name
fi
echo_eval g++ \
	$name.cpp \
	-I$HOME/prefix/eigen/include \
	-g \
	-O0 \
	-std=c++11 \
	-Wshadow \
	-o $name
echo_eval ./$name
