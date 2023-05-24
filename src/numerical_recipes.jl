# numerical_recipes --
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

export numerical_recipes

"""
    Source: Numerical recipes: the art of scientific computing,
    William Press et al., Third ed., Cambridge University Press, 2007
"""
function numerical_recipes(a,b,c)
    a = Float64(a);b = Float64(b);c = Float64(c)
    delta = b*b-4*a*c
    if delta < 0 # Test added to the original algorithm
        return (NaN64,NaN64)
    end
    q = -0.5*(b+sign1(b)*sqrt(delta))
    x1 = q/a
    x2 = c/q
    if x1 > x2
        return (x2,x1)
    else
        return (x1,x2)
    end
end
