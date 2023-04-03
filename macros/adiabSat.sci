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

function [Tadiab,Wadiab]=adiabSat(h,fig)
    // adiabSat computes the saturation temperature and humidity given the specific entalpy
    //
    // Syntax
    // [Tadiab,Wadiab]=adiabSat(h,fig)
    //
    // Parameters
    // h: specific enthalpy
    // fig: optional, boolean for display plot (default is fig=%f)
    // Tadiab: saturation temperature (in K)
    // Wadiab:  saturation humidity (in kg/kg of dry air)
    //
    // Description
    // adiabSat computes
    // the saturation temperature Tadiab (in K)
    // and humidity Wadiab (in kg/kg of dry air)
    // given the specific entalpy h (in J/kg of dry air).
    // If the optional argument fig = %t is given,
    // a schematic psychrometric chart pops up with
    // a graphical representation of the stationary state.
    // adiabSat is a main function of
    // the psychrometrics toolbox for Scilab.
    //
    // Examples
    // // Compute the temperature T
    // // and the humidity W
    // // at saturation condition given
    // // the specific enthalpy 82.4 kJ/kg of dry air
    // // and plot a graphical representation of the
    // // answer in a schematic psychrometric chart:
    // [T,W]=adiabSat(h=82.4e3,fig=%t) # inputs and outputs in SI units
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

    if ~exists("fig","local") then
        fig=%f
    end
    function z=foo(Tadiab)
        z=h-enthalpy(Tadiab,humidity(satPress(Tadiab)))
    end
    Tadiab=newtonraphson(foo,273.15,1e-5)
    padiab=satPress(Tadiab)
    Wadiab=humidity(padiab)
    if fig
        doPlot
        plotHumidity(1,"k",2)
        plotEnthalpy(h,"-.r",2)
        plot(Tadiab,Wadiab,"or","markersize",8)
    end
end
