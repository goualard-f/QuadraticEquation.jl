# scilab --
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

export scilab

"""
    Source: Scilab is not naive, 2010
    https://www.scilab.org/sites/default/files/prg/att/1741/scilabisnotnaive.pdf

    Code adapted from Algorithm 2 in the reference.
"""
function scilab(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    if a == 0
        if b == 0
            return (0.0,0.0) # What if c!=0?
        else
            x = -c/b
            if x > 0
                return (x, 0.0)
            else
                return (0.0,x)
            end
        end
    else
        bp = b/2
        delta = bp^2 - a*c
        if delta < 0.0
            return (NaN64,NaN64)
        elseif delta == 0
            return (-bp/a)
        else
            #s = sqrt(delta)
            if abs(bp) > abs(c)
                e = 1 - (a/bp)*(c/bp)
                s = sign1(e)*abs(bp)*sqrt(abs(e))
            else
                e = bp*(bp/c)-a
                s = sign1(e)*sqrt(abs(c))*sqrt(abs(e))
            end
            if b > 0
                g = 1
            else
                g = -1
            end
            h = -(bp + g*s)
            x1 = c/h
            x2 = h/a
            if x1 > x2
                return (x2,x1)
            else
                return (x1,x2)
            end
        end
    end     
end
