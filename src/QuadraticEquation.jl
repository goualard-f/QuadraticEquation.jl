# QuadraticEquation --
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

module QuadraticEquation

using Markdown

include("tools.jl")

include("baker.jl")
include("beebe.jl")
include("boost.jl")
include("dahlquist_bjorck.jl")
include("einarsson.jl")
include("gsl.jl")
include("higham.jl")
include("jenkins.jl")
include("kahan.jl")
include("mastronardi_van_dooren.jl")
#include("middlebrook.jl")
include("naive.jl")
include("nievergelt.jl")
include("nonweiler.jl")
include("numerical_recipes.jl")
include("panchekha_PLDI15.jl")
include("panchekha_racket.jl")
include("rust.jl")
include("scilab.jl")
include("sterbenz.jl")
include("young_gregory.jl")
end
