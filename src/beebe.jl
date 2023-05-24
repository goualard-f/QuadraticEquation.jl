# beebe --
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

export beebe

"""
    Source: The mathematical-function computation handbook, 
    Nelson H.F. Beebe, Springer, 2017

    Adapted from C Program QERT(), pp. 468--471.
"""
function beebe(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    if isnan(a) || isnan(b) || isnan(c) || isinf(a) || isinf(b) || isinf(c)
        return NaN64
    end
    if a == 0
        if b == 0
            x1 = NaN64
            x2 = NaN64
        elseif c == 0
            x1 = 0.0
            x2 = 0.0
        else
            x1 = -c/b
            x2 = 0.0
        end
    else
        if b == 0
            if c == 0
                x1 = 0
                x2 = 0
            else
                r = -c/a
                if r >= 0
                    x1 = sqrt(r)
                else
                    x1 = NaN64 # Imaginary
                end
                x2 = -x1
            end
        else
            if c == 0
                x1 = 0
                x2 = -b/a
            else
                na = exponent(a)
                nb = exponent(b)
                nc = exponent(c)
                n = max(na,nb,nc)
                a = a*2.0^-n
                b = b*2.0^-n
                c = c*2.0^-n
                r = kahan_discriminant_fma(a,b,c)
                if r >= 0
                    discr_sqrt = sqrt(r)
                    if b < 0
                        z = -0.5*(b - discr_sqrt)
                    else
                        z = -0.5*(b + discr_sqrt)
                    end
                    x1 = c/z
                    x2 = z/a
                else
                    # Imaginary roots
                    return (NaN64,NaN64)
                end
            end
        end
    end
    if x1 > x2
        return (x2,x1)
    else
        return (x1,x2)
    end
end
