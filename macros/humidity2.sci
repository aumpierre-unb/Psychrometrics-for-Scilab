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

function [W]=humidity2(Wsatwet,Tdry,Twet)
    // Syntax:
    //
    // [W]=humidity2(Wsatwet,Tdry,Twet)
    //
    // humidity2 computes
    //  the humidity W (in kg/kg of dry air)
    //  of humid air given
    //  the saturation humidity Wsatwet (in kg/kg of dry air) at wet bulb temperature,
    //  the dry bulb temperature Tdry (in K) and
    //  the wet bulb temperature Twet (in K).
    // humidity2 is an internal function of
    //  the psychrometrics toolbox for GNU Octave.
    W=((2501-2.326*(Twet-273.15))*Wsatwet-1.006*(Tdry-Twet))/ ..
    (2501+1.86*(Tdry-273.15)-4.186*(Twet-273.15))
end

