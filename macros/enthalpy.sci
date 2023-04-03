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

function [h]=enthalpy(Tdry,W)
    // enthalpy computes
    // the specific enthalpy of humid air given
    // the dry bulb temperature and
    // the humidity

    //
    // Syntax
    // [Tadiab,Wadiab]=adiabSat(h[,fig])
    //
    // Parameters
    // h: specific enthalpy
    // fig: optional, boolean for display plot (default is fig=%f)
    // Tadiab: saturation temperature (in K)
    // Wadiab:  saturation humidity (in kg/kg of dry air)
    //
    // Description
    // enthalpy computes
    // the specific enthalpy h (in J/kg of dry air)
    // of humid air given
    // the dry bulb temperature Tdry (in K) and
    // the humidity W (in kg/kg of dry air).
    // enthalpy is a main function of
    // the psychrometrics toolbox for Scilab.
    //
    // Examples
    // // Compute the specific enthalpy given
    // // the dry bulb temperature is 25 °C and
    // // the humidity is 7 g/kg of dry air.
    // Tdry=25+273.15 // dry bulb temperature in K
    // W=7e-3 // humidity in kg/kg of dry air
    // h=enthalpy(Tdry,W) // specific enthalpy in J/kg of dry air
    //
    // See also
    //  psychro
    //  dewTemp
    //  humidity
    //  satPress
    //  volume
    //  adiabSat
    //
    // Authors
    //  Alexandre Umpierre

    h=(1.006*(Tdry-273.15)+W*(2501+1.86*(Tdry-273.15)))*1e3
end
