# kahan --
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

export kahan

"""
    Source: On the cost of floating-point computation without extra precise arithmetic,
    William Kahan, 2004.

    Adapted from function `qdrtc()` on Page 8 in reference. Modified to handle
    equations of the form ax^2+bx+c=0 instead of ax^2-2bx+c=0.
"""
function kahan(a,b,c)
   a=Float64(a);b=Float64(b);c=Float64(c)
   delta = kahan_discriminant_fma(a,b,c)
    if delta < 0
        return (NaN64,NaN64)
    elseif delta == 0
        R = b/a
        S = sqrt(delta)/a
        x1 = R+S
        x2 = R-S
        if x1 > x2
            return (x2,x1)
        else
            return (x1,x2)
        end
    else
        q = -0.5*(b+sign(b)*sqrt(delta))
        x1 = q/a
        x2 = c/q
        if x1 > x2
            return (x2,x1)
        else
            return (x1,x2)
        end
    end
end
