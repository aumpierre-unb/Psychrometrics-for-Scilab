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

// buildHumidity generates a two column matrix of
// humidity and dry bulb temperature
// with given constant relative humidity phi.
// By default, constant relative humidity curves
// are ploted with black solid thin lines.
// buildHumidity is an internal function of
// the psychrometrics toolbox for Scilab.

function [T,W]=buildHumidity(phi)
    T1=273.15
    function z=foo(T2)
        z=.03-humidity(satPress(T2)*phi)
    end
    tol=abs(foo(50+273.15)/1e3)
    T2=newtonraphson(foo,50+273.15,tol)
    if T2>60+273.15 T2=60+273.15 end
    N=20
    T=[]
    W=[]
    for n=1:N
        T=[T;T1+(T2-T1)/(N-1)*(n-1)]
        psat=satPress(T($))
        pw=psat*phi
        W=[W;humidity(pw)]
    end
end
