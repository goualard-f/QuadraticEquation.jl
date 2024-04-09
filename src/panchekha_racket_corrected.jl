# panchekha_racket --
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

# This is the version corrected by Panchekha after we reported issues #81 and #83.

export panchekha_racket_corrected

function quadratic_discriminant_corrected(a,b,c)
    aa = abs(a); ab = abs(b); ac = abs(c)
    sa = a > 0; sb = b > 0; sc = c > 0
    x = sqrt(aa)*sqrt(ac)
    if sa == sc
        if (aa > 1 && x > 1) || (aa <= 1 && x <= 1)
            ax = aa/x
            axe = fma(ax,x,-aa)/x
            acx = ax*ac
            acxe = fma(ax,-ac,acx) + axe*ac
        else
            cx = ac/x
            cxe = fma(cx,x,-ac)/x
            acx = aa*cx
            acxe = fma(-aa,cx,acx) + cxe*a
        end
        dstar = (ab - x) - ((acx - x) - acxe)/2
        if dstar > 0
            return sqrt(dstar)*(sqrt(ab+x))
        elseif dstar == 0
            return 0.0
        else
            return NaN64
        end
    else
        if ab > x
            z = x/ab
            return ab*sqrt(1+z*z)
        else
            z = ab/x
            return x*sqrt(z*z+1)
        end
    end
end


"""
    Source: [An Accurate Quadratic Formula](https://pavpanchekha.com/blog/accurate-quadratic.html), 
    Pavel Panchekha, October 2021.
    Code used for the [Racket mathematical library](https://docs.racket-lang.org/math/number-theory.html#%28part._quadratics%29).
    See [actual code](https://github.com/racket/math/blob/4ec6ca9d43a04a74a770941247c7f1b4453e0703/math-lib/math/private/number-theory/quadratic.rkt#L82)

    Adapted from the corrected Racket code cited above.
"""
function panchekha_racket_corrected(a,b,c)
    a=Float64(a); b=Float64(b); c=Float64(c)
    b2 = b/2
    sqrtd = quadratic_discriminant_corrected(a,b2,c)
    if a == 0
        return -c/b
    elseif isnan(sqrtd)
        return (NaN64,NaN64)
    elseif sqrtd == 0
        return (-b2/a)
    elseif b < 0
        x1 = c/(sqrtd - b2)
        x2 = (sqrtd-b2)/a
    else
        x1 = (b2+sqrtd)/(-a)
        x2 = (-c)/(b2+sqrtd)
    end
    if x1 > x2
        return (x2,x1)
    else
        return (x1,x2)
    end
end
