# mastronardi --
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

export panchekha_PLDI15

"""
    Source: Automatically improving accuracy for floating-point expressions,
    Pavel Panchekha et al., Procs. of the 36th ACM SIGPLAN Conference on 
    Programming Language Design,  and Implementation, p.1--11, 2015.
"""
function panchekha_PLDI15(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    delta = b^2 - 4*a*c
    if delta < 0 # Test added to the original algorithm
        return (NaN64,NaN64)
    end
    if b < 0
        x1 = ((4*a*c)/(-b+sqrt(delta)))/(2*a)
        x2 = (-b+sqrt(delta))/(2*a)
        if x1 > x2
            return (x2,x1)
        else
            return (x1,x2)
        end
    end
    if b >= 0
        if b > 1e127
            x1 = -c/b
            x2 = -b/a + c/b
            if x1 > x2
                return (x2,x1)
            else
                return (x1,x2)
            end
        else
            x1 = (-b - sqrt(delta))/(2*a)
            x2 = (-b + sqrt(delta))/(2*a)
            if x1 > x2
                return (x2,x1)
            else
                return (x1,x2)
            end
        end
    end
    return nothing
end
