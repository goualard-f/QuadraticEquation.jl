# jenkins --
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

export jenkins

"""
    Source: Algorithm 493 Zeros of a real polynomial [C2],
    M.A. Jenkins, ACM TOMS 1(2)178--189, 1975

    Adapted from FORTRAN subroutine `QUAD` on page 189
"""
function jenkins(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    if a == 0
        if b != 0
            sr = -c/b
        else
            sr = 0
        end
        if sr > 0
            return (0.0,sr)
        else
            return (sr, 0.0)
        end
    end
    if c == 0
        lr = -b/a
        if lr > 0
            return (0.0,lr)
        else
            return (lr, 0.0)
        end
    end
    bp = b/2
    if abs(bp) >= abs(c)
        e = 1 - (a/bp)*(c/bp)
        if e < 0
            # No real solutions
            return (NaN64,NaN64)
        end
        d = sqrt(e)*abs(bp)
    else
        e = bp*(bp/abs(c)) - sign1(c)*a
        if e < 0
            # No real solutions
            return (NaN64,NaN64)
        end
         d = sqrt(e)*sqrt(abs(c))
    end
    lr = (-bp-sign1(b)*d)/a
    if lr != 0
        sr = (c/lr)/a
    else
        sr = 0.0
    end
    if lr > sr
        return (sr,lr)
    else
        return (lr, sr)
    end
end
