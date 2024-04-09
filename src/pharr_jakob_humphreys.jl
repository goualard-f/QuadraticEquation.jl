# pharr_jakob_humphreys --
#
#	Copyright 2024 Nantes University, France.
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

export pharr_jakob_humphreys

"""
    Source: Physically Based Rendering: From Theory to Implementation, 4th ed.,
    Matt Pharr, Wenzel Jakob, and Greg Humphreys
    https://pbr-book.org/
    
    Adapted from the function `bool Quadratic(float a, float b, float c, float *t0, float *t1)` in Section B.2.10.
    https://pbr-book.org/4ed/Utilities/Mathematical_Infrastructure#Quadratic
"""
function pharr_jakob_humphreys(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    if a == 0
        if b == 0
            return (NaN64)
        end
        return (-c/b)
    end
    discrim = DifferenceOfProducts(b,b,4*a,c)
    if discrim < 0
        return (NaN64,NaN64)
    end
    rootDiscrim = sqrt(discrim)
    q = -0.5*(b + copysign(rootDiscrim,b))
    x1 = q / a
    x2 = c / q
    if x1 > x2
        return (x2,x1)
    else
        return (x1,x2)
    end
end

"""
    Computes a*b - c*d accurately.

    Source: Physically Based Rendering: From Theory to Implementation, 4th ed.,
    Matt Pharr, Wenzel Jakob, and Greg Humphreys
    https://pbr-book.org/
    
    Adapted from the function `DifferenceOfProducts(Ta a, Tb b, Tc c, Td d)` 
    in Section B.2.9
    https://pbr-book.org/4ed/Utilities/Mathematical_Infrastructure#DifferenceOfProducts
"""
function DifferenceOfProducts(a,b,c,d)
    cd = c*d
    differenceOfProducts = fma(a,b,-cd)
    error = fma(-c,d,cd)
    return differenceOfProducts + error
end
