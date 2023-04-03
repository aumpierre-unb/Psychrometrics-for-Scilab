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

function [v]=volume(Tdry,W,p)
    // volume computes the specific volume of humid air given the dry bulb temperature, the humidity and the total pressure
    //
    // Syntax
    // [v]=volume(Tdry,W,p)
    //
    // Parameters
    // Tdry: dry bulb temperature (in K)
    // W: humidity (in kg/kg of dry air)
    // p: total pressure (in Pa)
    // v: specific volume (in cu. m/kg of dry air)
    //
    // Description
    // volume computes
    // the specific volume v (in cu. m/kg of dry air)
    // of humid air given
    // the dry bulb temperature Tdry (in K),
    // the humidity W (in kg/kg of dry air) and
    // the total pressure p (in Pa).
    // By default, total pressure is assumed
    // to be the atmospheric pressure
    // at sea level (p = 101325).
    // volume is a main function of
    // the psychrometrics toolbox for Scilab.
    //
    // Examples
    // // Compute the specific volume given
    // // the dry bulb temperature is 25 °C and
    // // the humidity is 7 g/kg of dry air
    // // at 1 atm total pressure:
    // Tdry=25+273.15 // dry bulb temperature in K
    // W=7e-3 // humidity in kg/kg of dry air
    // v=volume(Tdry,W) // specific volume in cu. m/kg of dry air
    //
    // See also
    //  psychro
    //  dewTemp
    //  humidity
    //  satPress
    //  enthalpy
    //  adiabSat

    if ~exists("p","local") then
        p=101325
    end
    v=0.287042*Tdry*(1+1.6078*W)/(p/1000)
end

