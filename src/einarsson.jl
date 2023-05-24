# einarsson --
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

export einarsson

"""
    Source: Accuracy and reliability in Scientific computing,
    Bo Einarsson, SIAM, 2005
    Section 1.2.2, Page 5

    Same stratey as [Menzel, 1977]
"""
function einarsson(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    delta = b*b - 4*a*c
    if delta < 0 # Test added to the original algorithm
        return (NaN64,NaN64)
    end
    if b < 0
        x1 = (-b+sqrt(delta))/(2*a)
        x2 = -(2*c)/(b-sqrt(delta))
    else
        x1 = (-b-sqrt(delta))/(2*a)
        x2 = -(2*c)/(b+sqrt(delta))
    end
    if x1 > x2
        return (x2,x1)
    else
        return (x1, x2)
    end
end
