# nonweiler --
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

export nonweiler

"""
    Source: Roots of low-order polynomial equations, 
    Terence R.F. Nonweiler, Comm. of the ACM (11)4269--270, April 1968

    Code adapted from procedure QUADROOTS() on Page 270 of the reference.
"""
function nonweiler(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    if a == 0
        println(stderr,"Case a==0 not handled!")
        return nothing
    end
    bp = (-b/a)/2
    cp = c/a
    delta = bp^2 - cp
    if delta == 0
        return bp
    elseif delta > 0
        if bp > 0
            x1 = sqrt(delta) + bp
        else
            x1 = bp - sqrt(delta)
        end
        x2 = cp/x1
        if x1 > x2
            return (x2,x1)
        else
            return (x1,x2)
        end
    else
        # No real solutions
        return (NaN64,NaN64)
    end
end
