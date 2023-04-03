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

function [W]=humidity(pw,p)
    // humidity computes the humidity W of humid air given the water vapor pressure and the total pressure
    //
    // Syntax
    // [W]=humidity(pw,p)
    //
    // Parameters
    // pw: water vapor pressure (in Pa)
    // p: total pressure (in Pa)
    // W: humidity (in kg/kg of dry air)
    //
    // Description
    // humidity computes
    // the humidity W (in kg/kg of dry air)
    // of humid air given
    // the water vapor pressure pw (in Pa) and
    // the total pressure p (in Pa).
    // By default, total pressure is assumed
    // to be the atmospheric pressure
    // at sea level (p = 101325).
    // humidity is a main function of
    // the psychrometrics toolbox for Scilab.
    //
    // Examples
    // // Compute the humidity of humid air
    // // at atmospheric pressure given
    // // water vapor pressure is 1 kPa
    // // at 1 atm total pressure:
    // pw=1e3; // water vapor pressure in Pa
    // W=humidity(pw) // saturation pressure in kg/kg of dry air
    //
    // See also
    //  psychro
    //  dewTemp
    //  satPress
    //  enthalpy
    //  volume
    //  adiabSat

    if ~exists("p","local") then
        p=101325
    end
    W=0.621945*pw/(p-pw)
end

