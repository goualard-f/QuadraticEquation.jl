# gsl --
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

export gsl

"""
    Source: GNU GSL 2.7
    
    Adapted from the code of `gsl_poly_solve_quadratic()` at:
    https://github.com/ampl/gsl/blob/dee1063dd57ec2841981b010eb732901b452c30a/poly/solve_quadratic.c#L28
"""
function gsl(a,b,c)
    a=Float64(a); b=Float64(b); c=Float64(c)
    if a == 0
        if b == 0
            return NaN64 # Does not return anything, even if c==0 (?)
        else
            return (-c/b)
        end
    end
    disc = b*b - 4*a*c
    if disc > 0
        if b == 0
            r = sqrt(-c/a)
            return (-r, r)
        else
            sgnb = b > 0 ? 1 : -1
            temp = -0.5*(b+sgnb*sqrt(disc))
            r1 = temp/a
            r2 = c/temp
            if r1 < r2
                return (r1,r2)
            else
                return (r2,r1)
            end
        end
    elseif disc == 0
        x0 = -0.5*b/a
        x1 = -0.5*b/a
        return (x0,x1)
    else
        # no real solution
        return (NaN64,NaN64)
    end 
end
