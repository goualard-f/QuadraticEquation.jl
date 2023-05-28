# young_gregory --
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

export young_gregory

"""
    Source: A survey of numerical mathematics, 
    David M. Young & Robert Todd Gregory, Dover Publications, 1988

    Code adapted from the descriptions on Pages 2--5 and on Pages 77--82.
"""
function young_gregory(a,b,c)
    a=Float64(a); b=Float64(b); c=Float64(c)
    if a == 0
        if b != 0
            return (-c/b)
        else
            if c != 0
                return (NaN64)
            else
                return (-Inf64,Inf64)
            end
        end
    else
        if b == 0
            if c == 0
                return (0.0,0.0)
            else
                ac = -c/a
                if ac < 0
                    return (NaN64,Nan64)
                else
                    x1 = -sqrt(ac)
                    x2 = sqrt(ac)
                    return (x1,x2)
                end
            end
        else
            if c == 0
                x = -b/a
                if x < 0
                    return (x,0.0)
                else
                    return (0.0,x)
                end
            else # a != 0, b != 0, c != 0
                b2c = b/(2*c)
                b2a = b/(2*a)
                delta = sqrt(abs(b2a))*sqrt(abs(b2c))
                if b2a == 0
                    if b2c == 0
                        x1 = sqrt(-c/a)
                        x2 = -x1
                        return (x2,x1)
                    elseif isinf(b2c)
                        return (NaN64, NaN64)
                    else
                        ac = a*c
                        if ac > 0
                            return (NaN64,NaN64)
                        else
                            x1 = -sign1(b2a)*sqrt(abs(c/a))*(delta+sqrt(1+delta^2))
                            x2 = sign1(b2a)*sqrt(abs(c/a))/(delta+sqrt(1+delta^2))
                        end
                    end
                elseif isinf(b2a)
                    if b2c == 0
                        return (NaN64,NaN64)
                    elseif isinf(b2c)
                        return (-Inf64,Inf64)
                    else
                        x1 = Inf64
                        x2 = (-2*c/b)/(1+sqrt(1-(4*a*c)/b^2))
                        return (x2,x1)
                    end
                else
                    if b2c == 0
                        ac = a*c
                        if ac > 0
                            return (NaN64,NaN64)
                        else
                            x1 = -sign1(b2a)*sqrt(abs(c/a))*(delta+sqrt(1+delta^2))
                            x2 = sign1(b2a)*sqrt(abs(c/a))/(delta+sqrt(1+delta^2))
                        end
                    elseif isinf(b2c)
                        x1 = -b/(2*a)*(1+sqrt(1-(4*a*c)/b^2))
                        x2 = 0
                        if x1 > x2
                            return (x2,x1)
                        else
                            return (x1,x2)
                        end
                    else
                        ac = a*c
                        if delta <= 1 && ac > 0
                            return (NaN64,NaN64)
                        end
                        if delta <= 1 && ac <= 0
                            x1 = -sign1(b2a)*sqrt(abs(c/a))*(delta+sqrt(1+delta^2))
                            x2 = sign1(b2a)*sqrt(abs(c/a))/(delta+sqrt(1+delta^2))
                            if x1 > x2
                                return (x2,x1)
                            else
                                return (x1,x2)
                            end
                        else
                            x1 = -b/(2*a)*(1+sqrt(1-(4*a*c)/b^2))
                            x2 = (-2*c/b)/(1+sqrt(1-(4*a*c)/b^2))
                            if x1 > x2
                                return (x2,x1)
                            else
                                return (x1,x2)
                            end
                        end
                    end
                end
            end
        end
    end 
end
