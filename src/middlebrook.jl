# middlebrook --
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

export middlebrook

"""
    Source: Methods of Design-Oriented Analysis: The Quadratic Equation Revisited, 
    R.D. Middlebrook, Procs. 22nd Annual conference Frointers in Education, IEEE,
    p. 95--102, 1992.

    Code adapted from Table 1, p. 100 in the reference.

    CAUTION: Does not seem to work due to calls to sqrt() with negative arguments.
"""
function middlebrook(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    if a == 0 || b == 0
        println(stderr,"Cases a==0 or b==0 not handled!")
        return nothing
    end
    Q = sqrt(a*c)/b
    if Q > 0.5
        return (NaN64,NaN64) # Complex solutions
    else
        F = 0.5 + 0.5*sqrt(1-4*Q^2)
        x1 = -(c/b)*(1/F)
        x2 = (-b/a)*F
        if x1 > x2
            return (x2,x1)
        else
            return (x1, x2)
        end
    end    
end
