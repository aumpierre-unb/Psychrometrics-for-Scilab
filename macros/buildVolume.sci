// Copyright (C) 2022 2023 Alexandre Umpierre
// This file is part of psyhrometrics Toolbox.
// psyhrometrics Toolbox is free software:
// you can redistribute it and/or modify it under the terms
// of the GNU General Public License (GPL) version 3
// as published by the Free Software Foundation.
// psyhrometrics Toolbox is distributed in the hope
// that it will be useful, but WITHOUT ANY WARRANTY
// without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.
// You should have received a copy of the
// GNU General Public License along with this program.
// It is also available at www.gnu.org/licenses/.

// buildVolume generates a two column matrix of
// humidity and dry bulb temperature
// with given constant specific volume v (in cu. m/kg).
// By default, constant specific volume curves
// are ploted with with green dash-doted thin lines.
// buildVolume is an internal function of
// the psychrometrics toolbox for Scilab.

function [T,W]=buildVolume(v)
    function z=foo(T1)
        z=v-volume(T1,humidity(satPress(T1)))
    end
    tol=v/1e3
    T1=newtonraphson(foo,50+273.15,tol)
    if humidity(satPress(T1))>.03
        function z=foo(T1)
            z=v-volume(T1,.03)
        end
        tol=abs(foo(50+273.15)/1e3)
        T1=newtonraphson(foo,50+273.15,tol)
    end
    function z=foo(T2)
        z=v-volume(T2,0)
    end
    tol=abs(foo(50+273.15)/1e3)
    T2=newtonraphson(foo,T1,tol)
    if T2>60+273.15 T2=60+273.15 end
    N=5
    T=[]
    W=[]
    for n=1:N
        T=[T;T1+(T2-T1)/(N-1)*(n-1)]
        function z=foo(W)
            z=v-volume(T(n),W)
        end
        tol=abs(foo(1e-3)/1e3)
        W=[W;newtonraphson(foo,1e-2,tol)]
    end
end
