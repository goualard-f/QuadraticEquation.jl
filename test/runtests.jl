using QuadraticEquation
using Crayons

include("tests.jl")

if length(ARGS) != 0
    # no test on the method names passed
    functions = tuple(ARGS...)
else
    functions = ("baker","beebe","boost","dahlquist_bjorck","einarsson",
                 "gsl","higham","jenkins","kahan","mastronardi_van_dooren",
                 #"middlebrook",
                 "naive","nievergelt","nonweiler",
                 "numerical_recipes","panchekha_PLDI15","panchekha_racket",
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

#include("systematic_tests.jl")
#include("fibonacci_tests.jl")
include("fibonacci_tests_randomized.jl")
#include("specific.jl")

