# tests --
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

invalidTests = Dict((1,2,"a")=>nothing,
                    (1,"a",3)=>nothing,
                    ("a",2,3)=>nothing,
                    ("a",2,"a")=>nothing,
                    ("a","a",3)=>nothing,
                    ("a","a","a")=>nothing)

noSolutionTests = Dict((1,2,NaN64)=>(NaN64),
                       (1,NaN64,3)=>(NaN64),
                       (1,NaN64,NaN64)=>(NaN64),
                       (NaN64,2,3)=>(NaN64),
                       (NaN64,2,NaN64)=>(NaN64),
                       (NaN64,NaN64,3)=>(NaN64),
                       (NaN64,NaN64,NaN64)=>(NaN64),
                       (0,0,1)=>(NaN64),
                       (1,2,Inf64)=>(NaN64),
                       (1,Inf64,3)=>(NaN64),
                       (1,Inf64,Inf64)=>(NaN64),
                       (Inf64,2,3)=>(NaN64),
                       (Inf64,2,Inf64)=>(NaN64),
                       (Inf64,Inf64,3)=>(NaN64),
                       (Inf64,Inf64,Inf64)=>(NaN64))

noRealSolutionTests = Dict((2,0,3)=>(NaN64, NaN64),
                           (1,1,1)=>(NaN64, NaN64),
                           (2.0^600,0,2.0^600)=>(NaN64, NaN64),
                           (-2.0^600,0,-2.0^600)=>(NaN64, NaN64))

degenerateInputTests = Dict(# a==0, b==0, c==0
                            (0,0,0)=>(Inf64,-Inf64),
                            # a==0, b==0, c!=0
                            # Put into nanTests
                            # a==0, b!=0, c==0
                            (0,1,0)=>(0.0),
                            # a==0, b!=0, c!=0
                            (0,1,2)=>(-2/1),
                            (0,3,4)=>(-4/3),
                            (0,2.0^600,-2.0^600)=>(1.0),
                            (0,2.0^600,2.0^600)=>(-1.0),
                            (0,2.0^-600,2.0^600)=>(-Inf64),
                            (0,2.0^600,2.0^-600)=>(0.0),
                            (0,2,-1.0e-323)=>(5.0e-324),
                            # a!=0, b==0, c==0
                            (3,0,0)=>(0.0),
                            (2.0*600,0,0)=>(0.0),
                            # a!=0, b==0, c!=0
                            (2,0,-3)=>(-sqrt(3/2),sqrt(3/2)),
                            (2.0^600,0,-2.0^600)=>(-1.0,1.0),
                            # a!=0, b!=0, c==0
                            (3,2,0)=>(-2/3,0.0),
                            (2.0^600,2.0^700,0)=>(-2.0^100,0),
                            (2.0^-600,2.0^700,0)=>(-Inf64,0.0),
                            (2.0^600,2.0^-700,0)=>(-0.0,0.0))

twoSolutionsTests = Dict(
    (1,-1,-1)=>(-0.6180339887498948,1.618033988749895),
    (1,1+2.0^-52,0.25+2.0^-53)=>((-1-2^-51)/2,-0.5),
    (1,2.0^-511+2.0^-563,2.0^-1024)=>(-7.458340888372987e-155,-7.458340574027429e-155),
    (1,2.0^27,0.75)=>(-134217728.0, -5.587935447692871e-09),
    (1,-1e9,1)=>(1e-09, 1000000000.0),
    (1.3407807929942596e154,-1.3407807929942596e154,-1.3407807929942596e154)=>(-0.6180339887498948, 1.618033988749895),
    (2.0^600,0.5,-2.0^-600)=>(-3.086568504549085e-181,1.8816085719976428e-181),
    (2.0^600,0.5,-2.0^600)=>(-1.0, 1.0),
    (8.0,2.0^800,-2.0^500)=>(-8.335018041099818e+239, 4.909093465297727e-91),
    (1.0,2.0^26,-0.125)=>(-67108864.0, 1.862645149230957e-09),
    (2.0^-1073,-2.0^-1073,-2.0^-1073)=>(-0.6180339887498948,1.618033988749895),
    (2.0^600,-2.0^-600,-2.0^-600)=>(-0.0,0.0),
    # Tests in Nivergelt paper >
    (-158114166017,316227766017,-158113600000)=>(0.99999642020057874,1.0),
    (-312499999999.0,707106781186.0,-400000000000.0)=>(1.131369396027,1.131372303775),
    (-67,134,-65)=>(0.82722631488372798,1.17277368511627202),
    (0.247260273973,0.994520547945,-0.138627953316)=>(-4.157030027041105,0.1348693622211607),
    (1,-2300000,2.0*10^11)=>(90518.994979145,2209481.005020854)
    #<
)

oneSolutionTests = Dict(
    (2.0^1023,2.0,2.0^-1023)=>(-2.0^-1023)
)
