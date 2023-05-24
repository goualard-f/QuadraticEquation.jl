# baker --
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

export baker

"""
    Source: You could learn a lot from a quadratic: overloading considered harmful,
    Henry G. Baker, ACM SIGPLAN Notices 33(1):30--38, 1998

    Adapted from the method shown in Section *Scale Factors* from the reference.
"""
function baker(a,b,c)
    a=Float64(a);b=Float64(b);c=Float64(c)
    if a == 0 || c == 0
        println(stderr,"Cases a==0 or c==0 not handled!")
        return nothing
    end
    # Division by sign(a)m_a2^{e_a}
    ma = significand(a)/2
    ea = exponent(a)+1
    pa = ea & ~1
    ka = pa >> 1
    ra = ea & 1
    b1 = b / (ma*2.0^ra)
    c1 = c / (ma*2.0^ra)
    # Substitution: x=-y sign(b1)2^{k_{c_1}-k_a}
    # and division by 2^{2k_{c_1}}
    mc1 = significand(c1)/2
    ec1 = exponent(c1)+1
    pc1 = ec1 & ~1
    kc1 = pc1 >> 1
    rc1 = ec1 & 1
    b2 = abs(b1)*2.0^(-kc1-ka-1)
    c2 = mc1*2.0^rc1
    if b2 >= sqrt(2)
        y1 = b2*(1+sqrt(1-c2/b2/b2))
        y2 = c2/y1
    else
        if b2^2 - c2 < 0
            # Imaginary solutions
            return (NaN64,NaN64)
        else
            y1 = b2 + sqrt(b2^2 - c2)
            y2 = c2/y1
        end
    end
    # Resubstituting variables
    x1 = -sign1(b1)*2.0^(kc1-ka)*y1
    x2 = -sign1(b1)*2.0^(kc1-ka)*y2
    if x1 > x2
        return (x2,x1)
    else
        return (x1,x2)
    end
end
