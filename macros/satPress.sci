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

function [psat]=satPress(Tdry)
    // satPress computes
    // the saturation pressure of humid air given
    // the dry bulb temperature
    //
    // Syntax
    // [psat]=satPress(Tdry)
    //
    // Parameters
    // Tdry: dry bulb temperature (in K)
    // psat: saturation pressure of humid air (in Pa)
    //
    // Description
    // satPress computes
    // the saturation pressure psat (in pa)
    // of humid air given
    // the dry bulb temperature Tdry (in K).
    // satPress is a main function of
    // the psychrometrics toolbox for Scilab.
    //
    // Examples
    // // Compute the saturation pressure given
    // // the dry bulb temperature is 25 °C.
    // Tdry=25+273.15 // dry bulb temperature in K
    // psat=satPress(Tdry) // saturation pressure in Pa
    //
    // Tdry=25+273.15 // dry bulb temperature in K
    // W=7e-3 // humidity in kg/kg of dry air
    // v=volume(Tdry,W) // specific volume in cu. m/kg of dry air
    //
    // See also
    //  psychro
    //  dewTemp
    //  humidity
    //  enthalpy
    //  volume
    //  adiabSat

    exec(get_absolute_file_path()+"constants.sci",-1)
    if -100<=Tdry-273.15 & Tdry-273.15<0
        k=c(1)/Tdry+..
        c(2)+..
        c(3)*Tdry+..
        c(4)*Tdry^2+..
        c(5)*Tdry^3+..
        c(6)*Tdry^4+..
        c(7)*log(Tdry)
    elseif 0<=Tdry-273.15 & Tdry-273.15<=200
        k=c(8)/Tdry+..
        c(9)+..
        c(10)*Tdry+..
        c(11)*Tdry^2+..
        c(12)*Tdry^3+..
        c(13)*log(Tdry)
    else
        error("Temperature must be in the range from 173.15 K to 473.15 K")
    end
    psat=exp(k)
end

