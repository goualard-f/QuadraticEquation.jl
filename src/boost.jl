# boost --
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

export boost

function detail_discriminant(a,b,c)
    w = 4*a*c
    e = fma(-c,4*a,w)
    f = fma(b,b,-w)
    return f+e
end

"""
    Source: C++ Boost libraries
    
    Code adapted from `quadratic_roots_imp()` at:
    https://github.com/boostorg/math/blob/c56f334348d5476783fba996d604fc5c6ae980c3/include/boost/math/tools/roots.hpp
"""
function boost(a,b,c)
    a=Float64(a); b=Float64(b); c=Float64(c)
    if a == 0
        if b == 0 && c != 0
            return (NaN64)
        elseif b == 0 && c == 0
            return 0.0 # Returning 0 when any value is solution (?)
        end
        return (-c/b)
    end
    if b == 0
        x0sq = -c/a
        if x0sq < 0
            return (NaN64,NaN64)
        end
        x0 = sqrt(x0sq)
        return (-x0,x0)
    end
    discriminant = detail_discriminant(a,b,c)
    if discriminant < 0
        return (NaN64,NaN64)
    end
    q = -(b+copysign(sqrt(discriminant),b))/2.0
    x0 = q/a
    x1 = c/q
    if x0 > x1
        return (x1,x0)
    else
        return (x0,x1)
    end
end
