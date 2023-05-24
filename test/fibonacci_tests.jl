# fibonacci_tests --
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


# Fibonacci tests [Kahan, 2004]
println(push!(stack,Crayon(foreground=:white,background=:light_blue)),"[[** Fibonacci testing **]")
print(pop!(stack))
for (name, fun) in methods
    println(push!(stack,Crayon(foreground=:blue)),"Testing $name...")
    print(pop!(stack))

    wrongNumberOfSolutions = 0
    wrongSolutions = 0
    goodSolutions = 0
    for n in 2:2:78 # Considering only values of `n` with real solutions
        Fn2 = Fibonacci(n-2)
        Fn1 = Fibonacci(n-1)
        Fn = Fibonacci(n)
        x1 = (Fn1+sqrt((-1)^n))/Fn
        x2 = (Fn1-sqrt((-1)^n))/Fn
        if x1 > x2
            (x1,x2) = (x2,x1)
        end
        y = fun(Fn,-2*Fn1,Fn2)
        if y == nothing
            wrongSolutions += 1
            continue
        end
        if length(y) == 1
            wrongNumberOfSolutions += 1
            if !(y ≈ x1) && !(y ≈ x2)
                println(stderr,"$n ($(Int64(Fn)) $(Int64(-2*Fn1)) $(Int64(Fn2))) : $y / $x1 $x2")
                wrongSolutions += 1
            end
        else
            if !(y[1] ≈ x1) || !(y[2] ≈ x2)
                println(stderr,"$n ($(Int64(Fn)) $(Int64(-2*Fn1)) $(Int64(Fn2))) : $y / $x1 $x2")
                wrongSolutions += 1
            else
                goodSolutions += 1
            end
        end
    end
    print(push!(stack,Crayon(foreground=:green)),goodSolutions)
    print(push!(stack,Crayon(foreground=:red))," $wrongNumberOfSolutions $wrongSolutions")
    print(pop!(stack))
    println(pop!(stack))
end

