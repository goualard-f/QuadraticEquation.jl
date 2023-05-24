# naive --
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

export naive

"""
    naive(a,b,c)

    Return the solutions to the equation `ax^2+bx+c=0`.

    Use the mathematical formula ``\$\\Delta=b^2-4ac\$`` to
    compute the discriminant. The solutions are obtained from the
    textbook formulas:
    ``\$x_{1,2}= (-b \\pm \\sqrt{\\Delta})/(2a)\$``
    
    - Return `(NaN64,NaN64)` if there are no real solutions;
    - Return one value if there is only one solution;
    - Return a pair `(x1,x2)` of two values, with `x1<x2` if 
    there are two solutions. 
"""
function naive(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    delta = b*b - 4*a*c
    if delta < 0
        return (NaN64,NaN64)
    elseif delta == 0
        return -b/(2*a)
    else
        x1 = (-b + sqrt(delta))/(2*a)
        x2 = (-b - sqrt(delta))/(2*a)
        if x1 > x2
            return (x2,x1)
        else
            return (x1,x2)
        end
    end
end
