# sterbenz --
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

export sterbenz

"""
    Return a pair (Kout,K2) of exponent such that neither is outside [-1022,1023].
    
    We have : Kout+K2 = Kin
"""
function keep_exponent_in_check(Kin)
    if -1022 <= Kin <= 1023
        return (Kin, 0)
    elseif Kin < -1022
        return (-1022, Kin+1022)
    else
        return (1023, Kin-1023)
    end
end

"""
    Source: Floating-point Computation, Pat H. Sterbenz, Prentice-Hall, 1974

    Adapted from the description of the method in the above reference. Added
    the use of Kahan's algorithm to compute the discriminant.
"""
function sterbenz(a,b,c)
  try 
    a=Float64(a);b=Float64(b);c=Float64(c)
  catch e
    println(stderr,"Parameters should be numbers!")
    return nothing
  end
  if isnan(a) || isnan(b) || isnan(c) ||
     isinf(a) || isinf(b) || isinf(c)
      return (NaN64)
  end
  # Degenerate cases
  if a == 0
     if b == 0
        if c == 0 # a==0, b==0, c==0
           return (Inf64, -Inf64)
        else      # a==0, b==0, c!=0
           return (NaN64)
        end
     else
        if c == 0 # a==0, b!=0, c==0
           return (0.0)
        else      # a==0, b!=0, c!=0
           return (-c/b)
        end
     end        
  else
     if b == 0
        if c == 0 # a!=0, b==0, c==0
           return (0.0)
        else      # a!=0, b==0, c!=0
           if sign1(a) == sign1(c)
              return (NaN64, NaN64)
           else
              ea = exponent(a)
              ec = exponent(c)
              ecp = ec - ea
              a2 = significand(a)
              dM = ecp & ~1 # dM = floor(ecp/2)*2
              M = dM>>1     # M = dM/2
              E = ecp & 1   # E = odd(ecp) ? 1 : 0
              c3 = significand(c)*2.0^(E)
              S = sqrt(-c3/a2)
              (M1,M2) = keep_exponent_in_check(M)
              x1 = (S*2.0^M2)*2.0^M1
              return (-x1,x1)
           end
        end
     else
        if c == 0 # a!=0, b!=0, c==0
           if sign1(a) == sign1(b)
              return (-b/a, 0.0)
           else
              return (0.0, -b/a)
           end
        else      # a!=0, b!=0, c!=0
           ea = exponent(a)
           eb = exponent(b)
           ec = exponent(c)
           K = eb - ea
           L = ea - 2*eb
           ecp = ec + L
           a2 = significand(a)
           b2 = significand(b)
           if ecp >= -920 && ecp < 995
              c2 = significand(c)*2.0^ecp
              delta = kahan_discriminant_fma(a2,b2,c2)
              if delta < 0
                 return (NaN64, NaN64)
              end
              (K1,K2) = keep_exponent_in_check(K)
              if delta > 0
                 y1 = -(2*c2)/(b2+sign1(b)*sqrt(delta))
                 y2 = -(b2+sign1(b)*sqrt(delta))/(2*a2)
                 x1 = (y1*2.0^K2)*2.0^K1
                 x2 = (y2*2.0^K2)*2.0^K1
                 return (min(x1,x2),max(x1,x2))
              end
              return  ((-b2/(2*a2))*2.0^K2)*2.0^K1
           end
           dM = ecp & ~1 # dM = floor(ecp/2)*2
           M = dM>>1     # M = dM/2
           E = ecp & 1   # E = odd(ecp) ? 1 : 0
           c3 = significand(c)*2.0^(E)
           S = sqrt(abs(c3/a2))
           if ecp < -920
              y1 = -b2/a2
              y2 = c3/(a2*y1)
              (dMK1, dMK2) = keep_exponent_in_check(dM+K)
              (K1,K2) = keep_exponent_in_check(K)
              x1 = (y1*2.0^K2)*2.0^K1
              x2 = (y2*2.0^dMK2)*2.0^(dMK1)
              return (min(x1,x2),max(x1,x2))
           end
           # ecp >= 995
           if sign1(a) == sign1(c)
              return (NaN64, NaN64)
           else
              (MK1,MK2) = keep_exponent_in_check(M+K)      
              x1 = (S*2.0^MK2)*2.0^(MK1)
              x2 = -x1
             return (x2, x1)
           end
        end
     end
  end
end
