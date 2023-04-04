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

function [Tdry,Twet,Tdew,Tadiab,W,Wsat,Wsatwet,Wadiab,h,v,phi,pw,psat,psatwet,rho]=psychro(Tdry,Twet,Tdew,W,h,v,phi,fig)
    // psychro computes the properties of humid air given any two parâmeters that configure a permanent state.
    //
    // Syntax
    // [Tdry,Twet,Tdew,Tadiab,W,Wsat,Wsatwet,Wadiab,h,v,phi,pw,psat,psatwet,rho]=psychro(Tdry,Twet,Tdew,W,h,v,phi,fig)
    //
    // Parameters
    // Tdry: dry bulb temperature (in K)
    // Twet: wet bulb temperature (in K)
    // Tdew: dew point temperature (in K)
    // Tadiab: adiabatic saturation temperature (in K)
    // W: humidity (in kg/kg of dry air)
    // Wsat: saturation humidity (in kg/kg of dry air)
    // Wsatwet: saturation humidity at wet bulb temperature (in kg/kg of dry air)
    // Wadiab: adiabatic saturation humidity (in kg/kg of dry air)
    // h: specific enthalpy (in J/kg of dry air)
    // v: specific volume (in cu. m/kg of dry air)
    // phi: relative humidity
    // pw: water vapor pressure (in Pa)
    // psat: saturation pressure (in Pa)
    // psatwet: saturation pressure at wet bulb temperature (in Pa)
    // rho: density (in kg/cu. m)
    // fig: optional show plot, default is false
    //
    // Description
    // psychro computes
    // the dry bulb temperature Tdry (in K),
    // the wet bulb temperature Twet (in K),
    // the dew point temperature Tdew (in K),
    // the adiabatic saturation temperature Tadiab (in K),
    // the humidit W (in kg/kg of dry air),
    // the saturation humidity Wsat (in kg/kg of dry air),
    // the saturation humidity at the wet bulb temperature Wsatwet (in kg/kg of dry air),
    // the adiabatic saturation humidity Wadiab (in kg/kg of dry air),
    // the specific enthalpy h (in J/kg of dry air),
    // the specific volume v (in cu. m/kg of dry air),
    // the the relative humidity phi,
    // the water vapor pressure pw (in Pa),
    // the water saturation pressure psat (in Pa),
    // the saturation pressure at the wet bulb temperature psatwet (in Pa) and
    // the density rho (in kg/cu. m) given
    // any two input arguments,
    // except the combination of water vapor pressure and
    // dew point temperature, which are not independent.
    // If fig = true is given, a schematic psychrometric chart
    // is plotted as a graphical representation
    // of the solution.
    // psychro is a main function of
    // the psychrometrics toolbox for Scilab.
    //
    // Examples
    // // Compute the dry bulb temperature,
    // // the wet bulb temperature,
    // // the dew point temperature,
    // // the adiabatic saturation temperature,
    // // the humidity,
    // // the saturation humidity,
    // // the saturation humidity at wet bulb temperature,
    // // the adiabatic saturation humidity,
    // // the specific enthalpy,
    // // the specific volume,
    // // the relative humidity,
    // // the water vapor pressure,
    // // the saturation pressure,
    // // the saturation pressure at wet bulb temperature and
    // // the density given
    // // the specific enthalpy is 79.5 kJ/kg and
    // // the relative humidity is 0.29 // and
    // // plot a graphical representation of the
    // // answer in a schematic psychrometric chart:
    // [Tdry,Twet,Tdew,Tadiab,W,Wsat,Wsatwet,Wadiab,h,v,phi,pw,psat,psatwet,rho]=..
    // psychro(h=79.5e3,phi=.29,fig=%t) // inputs and outputs in SI units
    //
    // // 8.5 cubic meters of humid air at
    // // dry bulb temperature of 293 K and
    // // wet bulb temperature of 288 K
    // // is subjected to two cycles of
    // // heating to 323 and adiabatic saturation.
    // // Compute the energy and water vapor demands.
    // // Assume the amount of dry air is constant.
    //
    // // The initial condition is
    // Tdry1=293;
    // Twet1=288;
    // [Tdry1,Twet1,Tdew1,Tadiab1,W1,Wsat1,Wsatwet1,Wadiab1,h1,v1,phi1,pw1,psat1,psatwet1,rho1]=..
    // psychro(Tdry=Tdry1,Twet=Twet1,fig=%t)
    //
    // // The thermodynamic state the after first adiabatic saturation is
    // Tdry2=323;
    // W2=W1;
    // [Tdry2,Twet2,Tdew2,Tadiab2,W2,Wsat2,Wsatwet2,Wadiab2,h2,v2,phi2,pw2,psat2,psatwet2,rho2]=..
    // psychro(Tdry=Tdry2,W=W2,fig=%t)
    // // The thermodynamic state the after first adiabatic saturation is
    // h3=h2;
    // [Tdry3,W3]=adiabSat(h=h3)
    // [Tdry3,Twet3,Tdew3,Tadiab3,W3,Wsat3,Wsatwet3,Wadiab3,h3,v3,phi3,pw3,psat3,psatwet3,rho3]=..
    // psychro(Tdry=Tdry3,W=W3)
    //
    // // The thermodynamic state after the second heating is
    // Tdry4=323;
    // W4=W3;
    // [Tdry4,Twet4,Tdew4,Tadiab4,W4,Wsat4,Wsatwet4,Wadiab4,h4,v4,phi4,pw4,psat4,psatwet4,rho4]=..
    // psychro(Tdry=Tdry4,W=W4,fig=%t)
    // // The thermodynamic state the after second adiabatic saturation is
    // h5=h4;
    // [Tdry5,W5]=adiabSat(h=h5)
    // [Tdry5,Twet5,Tdew5,Tadiab5,W5,Wsat5,Wsatwet5,Wadiab5,h5,v5,phi5,pw5,psat5,psatwet5,rho5]=..
    // psychro(Tdry=Tdry5,W=W5)
    //
    // // The energy demand is
    // (h5-h1)*(8.5/v1) // demand of energy
    //
    // // The water vapor demand is
    // (W5-W1)*(8.5/v1) // demand of water vapor
    //
    // See also
    //  dewTemp
    //  humidity
    //  satPress
    //  enthalpy
    //  volume
    //  adiabSat

    prot=funcprot()
    funcprot(0)
    if ~exists("Tdry","local") then
        Tdry=-1
    end
    if ~exists("Twet","local") then
        Twet=-1
    end
    if ~exists("Tdew","local") then
        Tdew=-1
    end
    if ~exists("W","local") then
        W=-1
    end
    if ~exists("h","local") then
        h=-1
    end
    if ~exists("v","local") then
        v=-1
    end
    if ~exists("phi","local") then
        phi=-1
    end
    if ~exists("fig","local") then
        fig=%f
    end
    a=bool2s([Tdry,Twet,Tdew,W,h,v,phi]==-1)
    if sum(a)~=5
        error(["Function psychro demands two and only two inputs.\nUnknowns must be assigned with ":"."])
    end
    if and(a==[0 0 1 1 1 1 1])
        psat=satPress(Tdry)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        Wsat=humidity(psat)
        W=humidity2(Wsatwet,Tdry,Twet)
        h=enthalpy(Tdry,W)
        v=volume(Tdry,W)
        function z=foo(pw)
            z=W-humidity(pw)
        end
        tol=abs(foo(psat)/1e3)
        pw=newtonraphson(foo,psat,tol)
        Tdew=dewTemp(pw)
        phi=pw/psat
        rho=(1+Wsatwet)/v
    elseif and(a==[0 1 0 1 1 1 1])
        function z=foo(pw)
            z=dewTemp(pw)-Tdew
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        W=humidity(pw)
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        phi=pw/psat
        h=enthalpy(Tdry,W)
        v=volume(Tdry,W)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry-1)/1e3)
        Twet=newtonraphson(foo,Tdew,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
    elseif and(a==[0 1 1 0 1 1 1])
        function z=foo(pw)
            z=W-humidity(pw)
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        Tdew=dewTemp(pw)
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        phi=pw/psat
        h=enthalpy(Tdry,W)
        v=volume(Tdry,W)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry-1)/1e3)
        Twet=newtonraphson(foo,Tdew,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
    elseif and(a==[0 1 1 1 0 1 1])
        function z=foo(W)
            z=h-enthalpy(Tdry,W)
        end
        tol=abs(foo(1e-2)/1e3)
        W=newtonraphson(foo,1e-2,tol)
        v=volume(Tdry,W)
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        function z=foo(pw)
            z=humidity(pw)-W
        end
        tol=abs(foo(psat)/1e3)
        pw=newtonraphson(foo,psat,tol)
        W=humidity(pw)
        phi=pw/psat
        Tdew=dewTemp(pw)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry-1)/1e3)
        Twet=newtonraphson(foo,Tdew,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
    elseif and(a==[0 1 1 1 1 0 1])
        function z=foo(W)
            z=v-volume(Tdry,W)
        end
        tol=abs(foo(1e-2)/1e3)
        W=newtonraphson(foo,1e-2,tol)
        h=enthalpy(Tdry,W)
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        function z=foo(pw)
            z=humidity(pw)-W
        end
        tol=abs(foo(psat)/1e3)
        pw=newtonraphson(foo,psat,tol)
        W=humidity(pw)
        phi=pw/psat
        Tdew=dewTemp(pw)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry-1)/1e3)
        Twet=newtonraphson(foo,Tdew,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
    elseif and(a==[0 1 1 1 1 1 0])
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        pw=phi*psat
        phi=pw/psat
        Tdew=dewTemp(pw)
        W=humidity(pw)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry)/1e3)
        Twet=newtonraphson(foo,Tdry,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        h=enthalpy(Tdry,W)
        v=volume(Tdry,W)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 0 0 1 1 1 1])
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        function z=foo(pw)
            z=dewTemp(pw)-Tdew
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        W=humidity(pw)
        function z=foo(Tdry)
            z=W-humidity2(Wsatwet,Tdry,Twet)
        end
        tol=abs(foo(Twet)/1e3)
        Tdry=newtonraphson(foo,Twet,tol)
        psat=satPress(Tdry)
        phi=pw/psat
        Wsat=humidity(psat)
        h=enthalpy(Tdry,W)
        v=volume(Tdry,W)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 0 1 0 1 1 1])
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        function z=foo(pw)
            z=W-humidity(pw)
        end
        tol=abs(foo(psatwet)/1e3)
        pw=newtonraphson(foo,psatwet,tol)
        Tdew=dewTemp(pw)
        function z=foo(Tdry)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Twet)/1e3)
        Tdry=newtonraphson(foo,Twet,tol)
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        phi=pw/psat
        h=enthalpy(Tdry,W)
        v=volume(Tdry,W)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 0 1 1 0 1 1])
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        Tdry=Twet
        function z=foo(W)
            z=h-enthalpy(Tdry,W)
        end
        tol=abs(foo(Wsatwet)/1e3)
        W=newtonraphson(foo,Wsatwet,tol)
        while W<humidity2(Wsatwet,Tdry,Twet)
            Tdry=Tdry+5e-3
            function z=foo(W)
                z=h-enthalpy(Tdry,W)
            end
            tol=abs(foo(Wsatwet)/1e3)
            W=newtonraphson(foo,Wsatwet,tol)
        end
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        v=volume(Tdry,W)
        rho=(1+Wsatwet)/v
        function z=foo(pw)
            z=W-humidity(pw)
        end
        tol=abs(foo(psat)/1e3)
        pw=newtonraphson(foo,psat,tol)
        Tdew=dewTemp(pw)
        phi=pw/psat
    elseif and(a==[1 0 1 1 1 0 1])
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        Tdry=Twet
        function z=foo(W)
            z=v-volume(Tdry,W)
        end
        tol=abs(foo(Wsatwet)/1e3)
        W=newtonraphson(foo,Wsatwet,tol)
        while W>humidity2(Wsatwet,Tdry,Twet)
            Tdry=Tdry+5e-3
            function z=foo(W)
                z=v-volume(Tdry,W)
            end
            tol=abs(foo(Wsatwet)/1e3)
            W=newtonraphson(foo,Wsatwet,tol)
        end
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        h=enthalpy(Tdry,W)
        rho=(1+Wsatwet)/v
        function z=foo(pw)
            z=W-humidity(pw)
        end
        tol=abs(foo(psat)/1e3)
        pw=newtonraphson(foo,psat,tol)
        Tdew=dewTemp(pw)
        phi=pw/psat
    elseif and(a==[1 0 1 1 1 1 0])
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        Tdry=Twet
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        W=humidity2(Wsatwet,Tdry,Twet)
        function z=foo(pw)
            z=W-humidity(pw)
        end
        tol=abs(foo(psat)/1e3)
        pw=newtonraphson(foo,psat,tol)
        while pw/psat>phi
            Tdry=Tdry+5e-3
            psat=satPress(Tdry)
            Wsat=humidity(psat)
            W=humidity2(Wsatwet,Tdry,Twet)
            function z=foo(pw)
                z=W-humidity(pw)
            end
            tol=abs(foo(psat)/1e3)
            pw=newtonraphson(foo,psat,tol)
        end
        Tdew=dewTemp(pw)
        Wsat=humidity(psat)
        h=enthalpy(Tdry,W)
        v=volume(Tdry,W)
        rho=(1+Wsatwet)/v
        phi=pw/psat
    elseif and(a==[1 1 0 0 1 1 1])
        function z=foo(pw)
            z=dewTemp(pw)-Tdew
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        w=humidity(pw)
        function z=foo(pw)
            z=humidity(pw)-W
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        tdew=dewTemp(pw)
        error("Dew point temperature and humidity\nare not independent variables.\nFor %g kg/kg humidity, one has\n%g K dew point temperature, and\nfor %g K dew point temperature, one has\n%g kg/kg humidity.",W,tdew,Tdew,w)
    elseif and(a==[1 1 0 1 0 1 1])
        function z=foo(pw)
            z=dewTemp(pw)-Tdew
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        W=humidity(pw)
        function z=foo(Tdry)
            z=h-enthalpy(Tdry,W)
        end
        tol=abs(foo(Tdew)/1e3)
        Tdry=newtonraphson(foo,Tdew,tol)
        psat=satPress(Tdry)
        phi=pw/psat
        v=volume(Tdry,W)
        Wsat=humidity(psat)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry-1)/1e3)
        Twet=newtonraphson(foo,Tdew,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 1 0 1 1 0 1])
        function z=foo(pw)
            z=dewTemp(pw)-Tdew
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        W=humidity(pw)
        function z=foo(Tdry)
            z=v-volume(Tdry,W)
        end
        tol=abs(foo(Tdew)/1e3)
        Tdry=newtonraphson(foo,Tdew,tol)
        psat=satPress(Tdry)
        phi=pw/psat
        h=enthalpy(Tdry,W)
        Wsat=humidity(psat)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry)/1e3)
        Twet=newtonraphson(foo,Tdry,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 1 0 1 1 1 0])
        function z=foo(pw)
            z=dewTemp(pw)-Tdew
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        function z=foo(Tdry)
            z=phi-pw/satPress(Tdry)
        end
        tol=abs(foo(Tdew)/1e3)
        Tdry=newtonraphson(foo,Tdew,tol)
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        W=humidity(pw)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry-1)/1e3)
        Twet=newtonraphson(foo,Tdew,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        h=enthalpy(Tdry,W)
        v=volume(Tdry,W)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 1 1 0 0 1 1])

        function z=foo(pw)
            z=humidity(pw)-W
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        Tdew=dewTemp(pw)
        function z=foo(Tdry)
            z=h-enthalpy(Tdry,W)
        end
        tol=abs(foo(Tdew)/1e3)
        Tdry=newtonraphson(foo,Tdew,tol)
        v=volume(Tdry,W)
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        phi=pw/psat
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry-1)/1e3)
        Twet=newtonraphson(foo,Tdew,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 1 1 0 1 0 1])
        function z=foo(pw)
            z=humidity(pw)-W
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        Tdew=dewTemp(pw)
        function z=foo(Tdry)
            z=v-volume(Tdry,W)
        end
        tol=abs(foo(Tdew)/1e3)
        Tdry=newtonraphson(foo,Tdew,tol)
        h=enthalpy(Tdry,W)
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        phi=pw/psat
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry)/1e3)
        Twet=newtonraphson(foo,Tdry,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 1 1 0 1 1 0])
        function z=foo(Tdry)
            z=W-humidity(phi*satPress(Tdry))
        end
        tol=abs(foo(50+273.15)/1e3)
        Tdry=newtonraphson(foo,50+273.15,tol)
        psat=satPress(Tdry)
        pw=phi*psat
        Wsat=humidity(psat)
        h=enthalpy(Tdry,W)
        v=volume(Tdry,W)
        Tdew=dewTemp(pw)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry-1)/1e3)
        Twet=newtonraphson(foo,Tdew,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 1 1 1 0 0 1])
        W=1e-2
        dW=W
        function z=foo(Tdry)
            z=v-volume(Tdry,W)
        end
        tol=abs(foo(50+273.15)/1e3)
        Tdry=newtonraphson(foo,50+273.15,tol)
        while abs(h-enthalpy(Tdry,W))>h/1e3
            if h>enthalpy(Tdry,W)
                W=W+dW
            else
                W=W-dW
                dW=dW/2
            end
            function z=foo(Tdry)
                z=v-volume(Tdry,W)
            end
            Tdry=newtonraphson(foo,50+273.15,tol)
        end
        function z=foo(pw)
            z=W-humidity(pw)
        end
        tol=abs(foo(1e3)/1e3)
        pw=newtonraphson(foo,1e3,tol)
        Tdew=dewTemp(pw)
        psat=satPress(Tdry)
        Wsat=humidity(psat)
        phi=pw/psat
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry)/1e3)
        Twet=newtonraphson(foo,Tdry,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 1 1 1 0 1 0])
        function [y,Tdry,psat]=foobar(pw,h,phi)
            W=humidity(pw)
            function z=foo(Tdry)
                z=h-enthalpy(Tdry,W)
            end
            tol=abs(foo(50+273.15)/1e3)
            Tdry=newtonraphson(foo,50+273.15,tol)
            function z=foo(psat)
                z=psat-satPress(Tdry)
            end
            tol=abs(foo(pw)/1e3)
            psat=newtonraphson(foo,pw,tol)
            y=pw/psat-phi
        end
        pw=0
        dp=1e3
        [y,Tdry,psat]=foobar(pw,h,phi)
        while abs(y)>1e-3
            if y<0
                pw=pw+dp
            else
                pw=pw-dp
                dp=dp/2
            end
            [y,Tdry,psat]=foobar(pw,h,phi)
        end
        W=humidity(pw)
        Tdew=dewTemp(pw)
        Wsat=humidity(psat)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry-1)/1e3)
        Twet=newtonraphson(foo,Tdew,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        v=volume(Tdry,W)
        rho=(1+Wsatwet)/v
    elseif and(a==[1 1 1 1 1 0 0])
        function [y,Tdry,psat]=foobaz(pw,v,phi)
            W=humidity(pw)
            function z=foo(Tdry)
                z=v-volume(Tdry,W)
            end
            tol=abs(foo(50+273.15)/1e3)
            Tdry=newtonraphson(foo,50+273.15,tol)
            function z=foo(psat)
                z=psat-satPress(Tdry)
            end
            tol=abs(foo(pw)/1e3)
            psat=newtonraphson(foo,pw,tol)
            y=pw/psat-phi
        end
        pw=0
        dp=1e3
        [y,Tdry,psat]=foobaz(pw,v,phi)
        while abs(y)>1e-3
            if y<0
                pw=pw+dp
            else
                pw=pw-dp
                dp=dp/2
            end
            [y,Tdry,psat]=foobaz(pw,v,phi)
        end
        W=humidity(pw)
        Tdew=dewTemp(pw)
        Wsat=humidity(psat)
        function z=foo(Twet)
            z=W-humidity2(humidity(satPress(Twet)),Tdry,Twet)
        end
        tol=abs(foo(Tdry-1)/1e3)
        Twet=newtonraphson(foo,Tdew,tol)
        psatwet=satPress(Twet)
        Wsatwet=humidity(psatwet)
        rho=(1+Wsatwet)/v
        h=enthalpy(Tdry,W)
    end
    Tadiab=adiabSat(h)
    Wadiab=humidity(satPress(Tadiab))
    if fig
        [tv,wv]=buildVolume(v)
        [tb,wb]=buildWetBulbTemp(Twet)
        [te,we]=buildEnthalpy(h)
        [th,wh]=buildHumidity(phi)
        doPlot()
        plot(tv,wv,"-.g","linewidth",2)
        plot(tb,wb,"b","linewidth",2)
        plot(te,we,"-.r","linewidth",2)
        plot(th,wh,"k","linewidth",2)
        plot(Tdry,W,"or","markersize",8,"markerfacecolor","r")
        plot(Twet,Wsatwet,"ob","markersize",8)
        plot(Tadiab,Wadiab,"or","markersize",8)
        plot(Tdew,W,"ok","markersize",8)
        if Wsat>.03
            wsat=.03
            plot([Tdry Tdry],[0 wsat],"-.k","linewidth",.5)
        else
            wsat=Wsat
            plot(Tdry,wsat,"ok","markersize",8)
            plot([Tdry Tdry 60+273.15],[0 wsat wsat],"-.k","linewidth",.5)
        end
        plot([Tdew Tdew 60+273.15],[0 W W],"--k","linewidth",.5)
        plot([Tadiab Tadiab 60+273.15],[0 Wadiab Wadiab],"--r","linewidth",.5)
        plot([Twet Twet 60+273.15],[0 Wsatwet Wsatwet],"-.b","linewidth",.5)
        gca().grid=[1,1]
        gca().grid_style=[9,9]
        gca().auto_scale="off"
        gca().tight_limits=["on","on"];
        gca().data_bounds=[0+273.15 60+273.15 0 .03]
        gcf().figure_size=[600,600]
    end
    funcprot(prot)
end
