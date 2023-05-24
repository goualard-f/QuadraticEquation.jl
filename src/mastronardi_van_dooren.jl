# mastronardi_van_dooren --
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

export mastronardi_van_dooren

"""
    Source: Revisiting stability of computing the roots of a quadratic polynomial, 
    N. Mastronardi & Paul van Dooren, 
    Electronic transactions on Numerical Analysis, (44)73--82, 2015.
    
    Adapted from the MATLAB code in Appendix B of the paper.

    The procedure does not handle linear equations (a=0), explicitly.
"""
function mastronardi_van_dooren(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    if a == 0
        return nothing
    end
    b1 = b/a
    c1 = c/a
    if b == 0
        x1 = sqrt(-c1)
        x2 = -x1
        return (x2,x1)
    end
    if c == 0
        x1 = -b1
        x2 = 0
        if x1 > x2
            return (x2,x1)
        else
            return (x1,x2)
        end
    end
    c1abs = abs(c1)
    alpha = sign1(b1)*sqrt(c1abs)
    beta = abs(b1)/(2*abs(alpha))
    e = sign1(c1)
    if e == -1
        y1 = beta + sqrt(beta^2+1)
        y2 = -1/y1
    else
        if beta >= 1
            y1 = beta + sqrt((beta+1)*(beta-1))
            y2 = 1/y1
        else
            # no real solution
            return (NaN64,NaN64)
        end
    end
    x1 = -y1*alpha
    x2 = -y2*alpha
    if x1 > x2
        return (x2, x1)
    else
        return (x1,x2)
    end
end
