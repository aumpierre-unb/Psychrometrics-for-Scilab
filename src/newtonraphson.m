#  Copyright (C) 2022 2023 Alexandre Umpierre
#
# This file is part of psychrometrics toolbox.
# psychrometrics toolbox is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU General Public License (GPL) version 3
# as published by the Free Software Foundation.
#
# psychrometrics toolbox is distributed in the hope
# that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the
# GNU General Public License along with this program
# (license GNU GPLv3.txt).
# It is also available at https://www.gnu.org/licenses/.

function [x]=newtonraphson(f,x,tol)
    # Syntax:
    #
    # [x]=newtonraphson(f,x,tol)
    #
    # newtonraphson computes the root of
    #  a function f(x) from a guess value x
    #  within a given tolerance tol fo f(x)
    #  using the method of Newton-Raphson.
    # newtonraphson is an internal function of
    #  the psychrometrics toolbox for GNU Octave.
    while abs(f(x))>tol
        a=(f(x+1e-7)-f(x))/1e-7;
        x=x-f(x)/a;
    end
end

