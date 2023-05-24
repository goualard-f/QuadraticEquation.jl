# tools --
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

"""
    sign(x)

    Define a `sign()` function that only returns `1`, if `x>=0`, or `-1`, if `x<0`.

    The value returned has the same type as `x`.
    CAUTION: `sign1(-0.0) == 1`
"""
function sign1(x)
    Type_x = typeof(x)
    if x == 0
        return Type_x(1)
    else
        return sign(x) # sign() returns a value in {-1,0,1}
    end
end

"""
    Veltkamp splitting of a double precision float, according to Dekker, 1971.
                                                                              
    Source: "Handbook of floating-point arithmetic", Muller et al.            
"""
function veltkamp_split(x)
    gamma = 134217729*x # 134217729 = 2^((52/2+1))+1
    delta = x - gamma
    xhi = gamma + delta
    xlo = x - xhi
    return (xhi,xlo)
end

"""
    Returns the error incurred when computing  `x\times y`,                
    the product `fl(x*y)` having already been computed and stored in `pxy`.
                                                                           
    Could be simplified with an `fma` instruction.                         
    Adapted from "Handbook of floating-point arithmetic", Muller et al.    
"""
function exactmult(x,y,pxy)
    (xhi,xlo) = veltkamp_split(x)
    (yhi,ylo) = veltkamp_split(y)
    t1 = -pxy + xhi*yhi
    t2 = t1 + xhi*ylo
    t3 = t2 + xlo*yhi
    e = t3 + xlo*ylo
    return e
end

function kahan_discriminant(a,b,c)
    d = b*b - 4*a*c
    if 3*abs(d) >= b*b + 4*a*c # b^2 and 4ac are different enough?
        return d
    end
    p = b*b
    q = 4*a*c
    dp = exactmult(b,b,p)
    dq = exactmult(4*a,c,q)
    d = (p-q) + (dp-dq)
    return d
end

function kahan_discriminant_fma(a,b,c)
    d = b*b - 4*a*c
    if 3*abs(d) >= b*b + 4*a*c # b^2 and 4ac are different enough?
        return d
    end
    p = b*b
    dp = fma(b,b,-p)
    q = 4*a*c
    dq = fma(4*a,c,-q)
    d = (p-q) + (dp-dq)
    return d
end
