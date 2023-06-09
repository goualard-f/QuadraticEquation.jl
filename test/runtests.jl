# runtests --
#
#	Copyright 2023 Nantes University, France.
#
#	This file is part of the QuadraticEquation library.
#
#	The QuadraticEquation library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation; either version 3 of the License, or (at your
#	option) any later version.
#	
#	The QuadraticEquation library is distributed in the hope that it will be useful,
# but	WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
#	or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
#	for more details.
#	
#	You should have received copies of the GNU General Public License and the
#	GNU Lesser General Public License along with the QuadraticEquation Library.
# If not,	see https://www.gnu.org/licenses/.

# You may test only a selection of the methods by passing their name on the
# command-line
# Example:
#  > julia runtests.jl baker nievergelt

using QuadraticEquation
using Crayons
using Random, Distributions

Random.seed!(41)

include("tests.jl")

if length(ARGS) != 0
    # no test on the method names passed
    functions = tuple(ARGS...)
else
    functions = ("baker","beebe","boost","dahlquist_bjorck","einarsson",
                 "gsl","higham","jenkins","kahan","mastronardi_van_dooren",
                 #"middlebrook",
                 "naive","nievergelt","nonweiler",
                 "numerical_recipes","panchekha_PLDI15",
                 "panchekha_racket", "panchekha_racket_corrected", 
                 "rust","scilab","sterbenz","young_gregory")
end

methods = []
for fun in functions
    push!(methods,(fun,@eval $(Symbol(fun))))
end


"""
    Fibonacci sequence.

    Computation of the nth term of the Fibonacci sequence using Binet's Formula.
    The result is returned as a double precision floating-point number. 
    Consequently, the function shall be called for `n` in [0,78] only, 
    otherwise the result is too large to be encoded by 53 bits.
    Throw `ArgumentError` if the parameter is invalid
"""
function Fibonacci(n)
    if isinteger(n) && 0 <= n <= 78 
        return Float64(round((((1+sqrt(big(5)))^n-(1-sqrt(big(5)))^n)/(sqrt(big(5))*big(2)^n))))
    else
        throw(ArgumentError("Parameter should be an integer in [0,78]!"))
    end
end



stack = CrayonStack()

include("systematic_tests.jl")
#include("fibonacci_tests.jl")
include("fibonacci_tests_randomized.jl")
include("random_tests.jl")
#include("random_tests_long.jl")
#include("specific.jl")

