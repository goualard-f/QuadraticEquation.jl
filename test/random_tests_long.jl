# random_tests --
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

# Generating random tests
# this version does not store the parameters of the quadratic beforehand. As
# a consequence, we may test much more triplets but each method handles different
# inputs.

# Generating `n` random coefficient triplets
n = 200_000_000

"""
    Generate a 64-bit float randomly.
    The values are not uniformly drawn.
    Any float from [-floatmax(Float64), floatmax(Float64)] can be generated, even subnormals.

    s: the expected sign (-1 or 1). If `0` it is also drawn randomly.
"""
function randfloat64(s = 0)
    if s == 0
        s = bitrand(1)[1]
    elseif s == -1
        s = 1
    else
        s = 0
    end
    e = rand(DiscreteUniform(0,2046))
    f = rand(DiscreteUniform(0,2^53-1))
    v = (UInt64(s) << 63) | (UInt64(e) << 52) | UInt64(f)
    return reinterpret(Float64,v)
end

"""
    Compute the roots of ax^2+bx+c using arbitrary precision
"""
function roots(a,b,c)
    a=big(a); b=big(b); c=big(c)
    delta = b*b - big(4.0)*a*c
    if delta < 0.0
        return nothing
    elseif delta == 0.0
        X = (-b/(big(2.0)*a))
        return X
    else
        X1 = (-b -big(sign1(b))*sqrt(delta))/(big(2.0)*a)
        X2 = -(big(2.0)*c)/(b+big(sign1(b))*sqrt(delta))
        if X1 <= X2
            return (X1,X2)
        else
            return (X2,X1)
        end
    end
end


# Searching worst error
for (name, fun) in methods
    println(push!(stack,Crayon(foreground=:blue)),"Testing $name...")
    print(pop!(stack))

    worstError = 0.0
    wrongSolutions = 0
    overflows = 0
    nparams = 0
    while nparams != n
        # Generating an eligible triplet of parameters for a quadratic
        eligible = false
        let (a,b,c,X) = (0.0,0.0,0.0,big(0.0))
            while !eligible
                (a,b,c) = (randfloat64(1),randfloat64(0),randfloat64(-1))
                X = roots(a,b,c)
                if X != nothing
                    if length(X) == 1 && X != 0.0 &&
                        floatmin(Float64) <= abs(X) <= floatmax(Float64)
                        nparams += 1
                        eligible = true
                    else
                        if X[1] != 0.0 && X[2]!=0.0 &&
                            floatmin(Float64) <= abs(X[1]) <= floatmax(Float64) &&
                            floatmin(Float64) <= abs(X[2]) <= floatmax(Float64)
                            nparams += 1
                            eligible = true
                        end
                    end
                end
            end
            let x = 0.0
                try
                    x = fun(a,b,c)
                catch e
                    #println("Exception catched: ($a,$b,$c)")
                    #exit(0)
                    wrongSolutions += 1
                    continue
                end
                if x == nothing || length(x) != length(X)
                    #println("Exception catched: $((a,b,c)) -> $X / $x")
                    #exit(0)
                    wrongSolutions += 1
                else
                    if length(x) == 1
                        if !isinf(x)
                            error = abs(X-x)/abs(X)
                        else
                            #println("Exception catched: $((a,b,c)) -> $X / $x")
                            #exit(0)
                            overflows += 1
                        end
                    else
                        if !isinf(x[1]) && !isinf(x[2])
                            error = max(abs(X[1]-x[1])/abs(X[1]),abs(X[2]-x[2])/abs(X[2]))
                        else
                            #println("Exception catched: $((a,b,c)) -> $X / $x")
                            #exit(0)
                            overflows += 1
                            error = 0.0
                        end
                    end
                    if worstError < error
                        worstError = error
                    end
                end
            end
        end
    end
    print(push!(stack,Crayon(foreground=:red)),"$wrongSolutions $overflows ")
    print(push!(stack,Crayon(foreground=:blue))," $(Float64(worstError/eps(Float64)))")
    print(push!(stack,Crayon(foreground=:magenta)),"×ε")
    print(pop!(stack))
    print(pop!(stack))
    println(pop!(stack))
end
