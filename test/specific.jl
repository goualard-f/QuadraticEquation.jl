# specific --
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

#params = (1.0,sqrt(4/5),1/5)
#params = (2.0^1023, 2, 2.0^-1023)
#params = (8944394323791464, -11055879401769514, 3416454622906707)
#params = (3,-4,1)
#params = 2.0^600 .*(1,1+2.0^-52,0.25+2.0^-53)
#params = 2.0^-550 .*(1.0,0.25,1.0)
#params = (1.0,0.25,1.0)
#params = (1200.0,0.0,0.0)
params = 2.0^-1073 .*(1.0,-1.0,-1.0)

println("Parameters: $params")
for (name, fun) in methods
    y = fun(params...)
    println("$name... $y")
end
