# nievergelt --
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

export nievergelt

"""
    Source: How (not) to solve quadratic equations,
    Yves Nievergelt, the College Mathematics Journal 34(2), p. 90--104, 2003
    
    Adapted from Algorithm 1, Page 92.
"""
function nievergelt(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    if a == 0 || b == 0 || c == 0
        println(stderr,"Case a==0 || b==0 || c==0 not handled explicitly!")
        return nothing
    end
    h = b/2
    d2 = h^2 - a*c
    if d2 >= 0
        d = sqrt(d2)
        t = -(h+sign1(h)*d)
        x1 = c/t
        x2 = t/a
        if x1 > x2
            return (x2,x1)
        else
            return (x1,x2)
        end
    else
        return (NaN64,NaN64)
    end
end
