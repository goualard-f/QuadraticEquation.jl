# systematic_tests --
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

for (name, fun) in methods
    println(push!(stack,Crayon(foreground=:blue)),"Testing $name...")
    print(pop!(stack))

    ## invalidTests
    println(push!(stack,Crayon(foreground=:magenta)),"[invalidTests]")
    print(pop!(stack))
    wrongNumberOfSolutions = 0
    wrongSolutions = 0
    goodSolutions = 0
    for (input, solutions) in invalidTests
        local x
        try
            x = fun(input...)
        catch e
            wrongSolutions += 1
            continue
        else
            if x != nothing
                println(stderr,"$input: $x / nothing")
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

    ## noSolutionTests
    println(push!(stack,Crayon(foreground=:magenta)),"[noSolutionTests]")
    print(pop!(stack))
    wrongNumberOfSolutions = 0
    wrongSolutions = 0
    goodSolutions = 0
    for (input, solutions) in noSolutionTests
        local x
        try
            x = fun(input...)
        catch e
            wrongSolutions += 1
            continue
        else
            if x==nothing || length(x) != 1
                println(stderr,"$input: $x / NaN64")
                wrongSolutions += 1
            else
                if !isnan(x)
                    println(stderr,"$input: $x / NaN64")
                    wrongSolutions += 1
                else
                    goodSolutions += 1
                end
            end
        end
    end
    print(push!(stack,Crayon(foreground=:green)),goodSolutions)
    print(push!(stack,Crayon(foreground=:red))," $wrongNumberOfSolutions $wrongSolutions")
    print(pop!(stack))
    println(pop!(stack))

    ## noRealSolutionTests
    println(push!(stack,Crayon(foreground=:magenta)),"[noRealSolutionTests]")
    print(pop!(stack))
    wrongNumberOfSolutions = 0
    wrongSolutions = 0
    goodSolutions = 0
    for (input, solutions) in noRealSolutionTests
        local x
        try
            x = fun(input...)
        catch e
            wrongSolutions += 1
            continue
        else
            if x==nothing || length(x) != 2
                println(stderr,"$input: $x / (NaN64,NaN64)")
                wrongSolutions += 1
            else
                if !isnan(x[1]) || !isnan(x[2])
                    println(stderr,"$input: $x / (NaN64,NaN64)")
                    wrongSolutions += 1
                else
                    goodSolutions += 1
                end
            end
        end
    end
    print(push!(stack,Crayon(foreground=:green)),goodSolutions)
    print(push!(stack,Crayon(foreground=:red))," $wrongNumberOfSolutions $wrongSolutions")
    print(pop!(stack))
    println(pop!(stack))

    ## degenerateInputTests
    println(push!(stack,Crayon(foreground=:magenta)),"[degenerateInputTests]")
    print(pop!(stack))
    wrongNumberOfSolutions = 0
    wrongSolutions = 0
    goodSolutions = 0
    for (input, solutions) in degenerateInputTests
        local x
        try
            x = fun(input...)
        catch e
            wrongSolutions += 1
            continue
        else
            if x==nothing
                println(stderr,"$input: $x / $(solutions)")
                wrongSolutions += 1
            elseif length(x) != length(solutions)
                wrongNumberOfSolutions += 1
                println(stderr,"$input: $x / $(solutions)")
                if length(x) == 1 && !(x ≈ solutions[1]) && !(x ≈ solutions[2])
                    wrongSolutions += 1
                elseif length(x) == 2 && !(x[1] ≈ solutions) && !(x[2] ≈ solutions)
                    wrongSolutions += 1
                end
            else
                if length(x) == 1
                    if x != solutions
                        println(stderr,"$input: $x / $solutions")
                        wrongSolutions += 1
                    else
                        goodSolutions += 1
                    end
                else
                    if !(x[1] ≈ solutions[1]) || !(x[2] ≈ solutions[2])
                        println(stderr,"$input: $x / $solutions")
                        wrongSolutions += 1
                    else
                        goodSolutions += 1
                    end
                end
            end
        end
    end
    print(push!(stack,Crayon(foreground=:green)),goodSolutions)
    print(push!(stack,Crayon(foreground=:red))," $wrongNumberOfSolutions $wrongSolutions")
    print(pop!(stack))
    println(pop!(stack))

    
    ## twoSolutionsTests
    println(push!(stack,Crayon(foreground=:magenta)),"[twoSolutionsTests]")
    print(pop!(stack))
    wrongNumberOfSolutions = 0
    wrongSolutions = 0
    goodSolutions = 0
    for (input, solutions) in twoSolutionsTests
        x = fun(input...)
        if length(x) != 2
            wrongNumberOfSolutions += 1
            if !(x ≈ solutions[1]) && !(x ≈ solutions[2])
                println(stderr,"$input: $x / $(solutions[1]) $(solutions[2])")
                wrongSolutions += 1
            end
        else
            (x1,x2) = x
            if !(x1 ≈ solutions[1]) || !(x2 ≈ solutions[2])
                wrongSolutions += 1
                println(stderr,"$input: $x1 $x2 / $(solutions[1]) $(solutions[2])")
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
