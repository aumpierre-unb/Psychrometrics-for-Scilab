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

// buildWetBulbTemp generates two column matrix of
// humidity and dry bulb temperature
// with given constant wet bulb temperature Twet (in K).
// By default, constant specific volume curves
// are ploted with with blue solid thin lines.
// buildWetBulbTemp is an internal function of
// the psychrometrics toolbox for Scilab.

function [T,W]=buildWetBulbTemp(Twet)
    T1=Twet
    if humidity(satPress(T1))>.03
        function z=foo(T1)
            z=.03-humidity2(humidity(satPress(Twet)),T1,Twet)
        end
        tol=abs(foo(50+273.15)/1e3)
        T1=newtonraphson(foo,50+273.15,tol)
    end
    function z=foo(T2)
        z=0-humidity2(humidity(satPress(Twet)),T2,Twet)
    end
    tol=abs(foo(50+273.15)/1e3)
    T2=newtonraphson(foo,50+273.15,tol)
    if T2>60+273.15 T2=60+273.15 end
    N=5
    T=[]
    W=[]
    for n=1:N
        T=[T;T1+(T2-T1)/(N-1)*(n-1)]
        function z=foo(W)
            z=W-humidity2(humidity(satPress(Twet)),T(n),Twet)
        end
        tol=abs(foo(1e-3)/1e3)
        W=[W;newtonraphson(foo,1e-2,tol)]
    end
end
