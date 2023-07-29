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

function [Tadiab,Wadiab]=adiabSat(h,fig)
    // adiabSat computes temperature and the humidity at saturation condition given the specific enthalpy
    //
    // Syntax
    // [Tadiab,Wadiab]=adiabSat(h,fig)
    //
    // Parameters
    // h: specific enthalpy (in J/kg of dry air)
    // fig: optional show plot, default is false
    // Tadiab: adiabatic saturation temperature (in K)
    // Wadiab: adiabatic saturation humidity (in kg/kg of dry air)
    //
    // Description
    // adiabSat computes
    // the saturation temperature Tadiab (in K)
    // and humidity Wadiab (in kg/kg of dry air)
    // given the specific enthalpy h (in J/kg of dry air).
    // If the optional argument fig = %t is given,
    // a schematic psychrometric chart pops up with
    // a graphical representation of the stationary state.
    // adiabSat is a main function of
    // the psychrometrics toolbox for Scilab.
    //
    // Examples
    // // Compute the temperature and
    // // the humidity at saturation condition given
    // // the specific enthalpy 82.4 kJ/kg of dry air
    // // and plot a graphical representation of the
    // // answer in a schematic psychrometric chart:
    // h=82.4e3; // enthalpy in J/kg dry air
    // [T,W]=adiabSat(h,%t) // inputs and outputs in SI units
    //
    // See also
    //  psychro
    //  dewTemp
    //  humidity
    //  satPress
    //  enthalpy
    //  volume
    //
    // Authors
    //  Alexandre Umpierre

    prot=funcprot()
    funcprot(0)
    if ~exists("fig","local") then
        fig=%f
    end
    function z=foo(Tadiab)
        z=h-enthalpy(Tadiab,humidity(satPress(Tadiab)))
    end
    Tadiab=newtonraphson(foo,273.15,1e-5)
    padiab=satPress(Tadiab)
    Wadiab=humidity(padiab)
    v=volume(Tadiab,Wadiab)
    if fig
        [tv,wv]=buildVolume(v)
        [tb,wb]=buildWetBulbTemp(Tadiab)
        [te,we]=buildEnthalpy(h)
        [th,wh]=buildHumidity(1)
        doPlot()
        plot(tv,wv,"--","color","green3","linewidth",2)
        plot(tb,wb,"--","color","dodgerblue1","linewidth",2)
        plot(te,we,"--","color","red","linewidth",2)
        plot(th,wh,"-","color","black","linewidth",2)
        plot(Tadiab,Wadiab,"or","markersize",8)
        plot([Tadiab Tadiab 60+273.15],[0 Wadiab Wadiab],"--r","linewidth",.5)
    end
    funcprot(prot)
end
