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

// doPlot plots
// a schematic psychrometric chart with
// previously computed curves with
// constant dry bulb temperature,
// constant specific volume,
// constant specific enthalpy and
// constant relative humidity.
// Edition of this file is highly not advised.
// doPlot is an internal function of
// the psychrometrics toolbox for Scilab.

function doPlot()
    exec(get_absolute_file_path()+"plotData.sci",-1)
    if winsid()==[]
        i=0
    else
        i=max(winsid())+1
    end
    scf(i)
    scf(i).anti_aliasing='16x'
    for i=1:size(uv,2)/2
        plot(uv(:,2*(i-1)+1),uv(:,2*(i-1)+2),"-.g","linewidth",1.2)
    end
//    text(286.8,.0180,"0.86 cu.m/kg","color","//1D8B20")
//    text(282.0,.0135,"0.84 cu.m/kg","color","//1D8B20")
    for i=1:size(uT,2)/2
        plot(uT(:,2*(i-1)+1),uT(:,2*(i-1)+2),"-b","linewidth",1.2)
    end
//    text(293.3,.0205,"25 °C","color","b")
//    text(298.3,.0275,"30 °C","color","b")
    for i=1:size(ue,2)/2
        plot(ue(:,2*(i-1)+1),ue(:,2*(i-1)+2),"-.r","linewidth",1.2)
    end
//    text(273,.0065,"20 kJ/kg","color","r")
//    text(277,.0084,"30 kJ/kg","color","r")
    for i=1:size(uh,2)/2
        plot(uh(:,2*(i-1)+1),uh(:,2*(i-1)+2),"-k","linewidth",1.2)
    end
//    text(308,.028,"80 %","color","k")
//    text(313.2,.028,"60 %","color","k")
//    text(321,.028,"40 %","color","k")
    for i=1:size(uH,2)/2
        plot(uH(:,2*(i-1)+1),uH(:,2*(i-1)+2),"--k","linewidth",1.2)
    end
    xlabel("Dry Bulb Temperature (K)")
    ylabel("Humidity (kg vapor / kg dry air)")
    gca().data_bounds=[0+273.15 60+273.15 0 .03]
    gca().grid=[1,1]
    gca().grid_style=[9,9]
    gca().y_location="right"
    gcf().figure_size=[600,600]
//    text(326.6,.028 ,"30 %","color","//4B4B4B")
//    text(328.6,.0255,"25 %","color","//4B4B4B")
//    text(328.6,.020 ,"20 %","color","//4B4B4B")
//    text(328.6,.015 ,"15 %","color","//4B4B4B")
//    text(328.6,.0098,"10 %","color","//4B4B4B")
//    text(328.6,.0046, "5 %","color","//4B4B4B")
end
