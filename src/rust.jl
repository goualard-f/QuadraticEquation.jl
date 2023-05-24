# rust --
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

export rust

"""
    Source: Rust *roots* mathematical library

    Adapted from the code for `find_roots_linear()` at:
    https://docs.rs/roots/latest/src/roots/analytical/linear.rs.html#48-58
"""
function find_roots_linear(b,c)
    if b == 0
        if c == 0
            return (0.0)
        else
            return (NaN64)
        end
    else
        return -c/b
    end
end


"""
    Source: Rust *roots* mathematical library

    Adapted from the code for `find_roots_quadratic()` at:
    https://docs.rs/roots/latest/src/roots/analytical/quadratic.rs.html#28
"""
function rust(a,b,c)
    a=Float64(a); b=Float64(b); c=Float64(c)
    if a == 0
        return find_roots_linear(b,c)
    else
        discriminant = b*b - 4*a*c
        if discriminant < 0
            return (NaN64,NaN64)
        else
            a2x2 = 2*a
            if discriminant == 0
                return (-b/a2x2)
            else
                sq = sqrt(discriminant)
                if b < 0
                    (same_sign, diff_sign) = (-b+sq, -b-sq)
                else
                    (same_sign, diff_sign) = (-b-sq, -b+sq)
                end
                if abs(same_sign) > abs(a2x2)
                    a0x2 = 2*c
                    if abs(diff_sign) > abs(a2x2)
                        x1 = a0x2/same_sign
                        x2 = a0x2/diff_sign
                    else
                        x1 = a0x2/same_sign
                        x2 = same_sign/a2x2
                    end
                else
                    x1 = diff_sign/a2x2
                    x2 = same_sign/a2x2
                end
                if x1 < x2
                    return (x1,x2)
                else
                    return (x2,x1)
                end
            end
        end
    end
end
