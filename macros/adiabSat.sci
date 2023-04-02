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
    // hveps2fDRe computes
    // the Reynolds number and
    // the Darcy friction factor based on
    // the flow speed and
    // the pipe"s relative roughness
    //
    // Syntax
    // [Re,fD]=hveps2fDRe(h,g,mu,rho,v,L,eps,[,fig])
    //
    // Parameters
    // h: head loss
    // g: gravitational acceleration
    // mu: fluid"s dynamic viscosity
    // rho: fluid"s density
    // v: flow speed
    // L: pipe"s length
    // eps: pipe"s relative roughness
    // fig: optional, boolean for display plot (default is fig=%f)
    // Re: Reynolds number
    // fD: Darcy friction factor
    //
    // Description
    // hQthk2fDRe computes
    // the Reynolds number and
    // the Darcy friction factor for a internal fluid flow given 
    // the head loss h, 
    // the gravitational acceleration g, 
    // the fluid"s dynamic viscosity mu and density rho, and 
    // the flow speed v, and
    // the pipe"s length L and relative roughness eps.
    // Inputs are to be given in a consistent system of units.
    //
    // Examples
    // // Compute the Reynolds number Re and
    // // the Darcy friction factor fD given
    // // the head loss h=40 cm,
    // // the gravitational acceleration g=981 cm/s/s,
    // // the fluid"s the dynamic viscosity mu=8.9e-3 g/cm/s and
    // // density rho=0.98 g/cc,
    // // the flow speed v=1.1e2 cm/s and
    // // the pipe"s length L=2.5e3 cm and
    // // relative roughness eps=2.5e-3:
    // //
    // // This call computes Re e fD:
    // [Re,fD]=hveps2fDRe(40,981,8.9e-3,0.98,1.1e2,2.5e3,2.5e-3,%f)
    // // Alternatively:
    // h=40.. //head loss (cm)
    // g=981.. //gravitational acceleration (cm/s/s)
    // mu=8.9e-3.. //fluid"s dynamic viscosity (g/cm/s)
    // rho=0.98.. //fluid"s density (g/cc)
    // v=50.. //flow speed (cm/s)
    // L=2.5e3.. //pipe"s length (cm)
    // eps=2.5e-3.. //pipe"s relative roughness
    // [Re,fD]=hveps2fDRe(h,g,mu,rho,v,L,eps)
    // // This call computes Re e fD
    // // and plots a representation of the solution
    // // on a schematic Moody diagram:
    // [Re,fD]=hveps2fDRe(40,981,8.9e-3,0.98,50,2.5e3,2.5e-3,%t)
    // // Compute the Reynolds number Re and
    // // the Darcy friction factor fD given
    // // the head loss h=40 cm,
    // // the gravitational acceleration g=981 cm/s/s,
    // // the fluid"s the dynamic viscosity mu=8.9e-3 g/cm/s and
    // // density rho=0.98 g/cc,
    // // the flow speed v=20 cm/s and
    // // the pipe"s length L=2.5e3 cm and
    // // relative roughness eps=0.005:
    // //
    // // This call computes Re e fD
    // // and plots a representation of the solution
    // // on a schematic Moody diagram:
    // [Re,fD]=hveps2fDRe(40,981,8.9e-3,0.98,20,2.5e3,0.005,%t)
    // // Compute the Reynolds number Re and
    // // the Darcy friction factor fD given
    // // the head loss h=40 cm,
    // // the gravitational acceleration g=981 cm/s/s,
    // // the fluid"s the dynamic viscosity mu=8.9e-3 g/cm/s and
    // // density rho=0.98 g/cc,
    // // the flow speed v=26 cm/s and
    // // the pipe"s length L=2.5e3 cm and
    // // relative roughness eps=0.005:
    // //
    // // This call computes Re e fD
    // // and plots a representation of the solution
    // // on a schematic Moody diagram:
    // [Re,fD]=hveps2fDRe(40,981,8.9e-3,0.98,26,2.5e3,0.005,%t)
    //
    // See also
    //  epsfD2Re
    //  epsRe2fD
    //  hDeps2fDRe
    //  hvthk2fDRe
    //  hQeps2fDRe
    //  hQthk2fDRe
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
