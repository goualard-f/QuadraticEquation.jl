# higham --
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

export higham

"""
    Source: Accuracy and stability of numerical algorithms, 
    Higham, SIAM, 2002

    Adapted from the formulae in Section 1.8, Page 10--11.
"""
function higham(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    delta = b*b - 4*a*c
    if delta < 0
        return (NaN64,NaN64)
    else
        x1 = (-(b+sign1(b)*sqrt(delta)))/(2*a)
        x2 = c/(a*x1)
        if x1 > x2
            return (x2,x1)
        else
            return (x1,x2)
        end
    end
end
