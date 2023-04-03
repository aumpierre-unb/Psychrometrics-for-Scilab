// Copyright (C) 2022 2023 Alexandre Umpierre
// This file is part of psyhrometrics Toolbox.
// psyhrometrics Toolbox is free software:
// you can redistribute it and/or modify it under the terms
// of the GNU General Public License (GPL) version 3
// as published by the Free Software Foundation.
// internal-fluid-flow Toolbox is distributed in the hope
// that it will be useful, but WITHOUT ANY WARRANTY
// without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.
// You should have received a copy of the
// GNU General Public License along with this program.
// It is also available at www.gnu.org/licenses/.

function [x]=newtonraphson(f,x,tol)
    // newtonraphson computes the root of
    // a function from a guess value
    // within a given tolerance
    // using the method of Newton-Raphson.
    // newtonraphson is an internal function of
    // the psychrometrics toolbox for Scilab

    while abs(f(x))>tol
        a=(f(x+1e-7)-f(x))/1e-7
        x=x-f(x)/a
    end
end

