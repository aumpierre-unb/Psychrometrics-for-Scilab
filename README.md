# `psychrometrics`

[![DOI](https://zenodo.org/badge/619319456.svg)](https://zenodo.org/badge/latestdoi/619319456)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/aumpierre-unb/Psychrometrics-for-Scilab)

## Install and load `psychrometrics` Toolbox for Scilab

1\. Download ```v0.1.3.zip``` file from [Releases](https://github.com/aumpierre-unb/Psychrometrics-for-Scilab/releases).

2\. Set Scilab current directory to the download folder.

3\. To install and load the toolbox, type:

```powershell-interactive
atomsInstall('v0.1.3.zip'),..
atomsLoad('psychrometrics')
```

## Citation of `psychrometrics` Toolbox for Scilab

You can cite all versions (both released and pre-released), by using
[DOI 105281/zenodo.6927994](https://doi.org/10.5281/zenodo.7796323).

This DOI represents all versions, and will always resolve to the latest one.

To cite the last released version, please check
https://zenodo.org/account/settings/github/repository/aumpierre-unb/Psychrometrics-for-Scilab.

---

The following is a very short introduction to the steady internal flow of an incompressible and inviscid fluid and to the Psychrometrics Toolbox for Scilab.

Internal flow is a pretty extensive topic in fluid mechanics and there are a lot of important and interesting observations related to it that are not taken into account in this text, because they have no direct impact the computation performed by the functions in this toolbox. Our focus here is a small set of equations that described the phenomenon and are required to solve problems on Psychrometrics.

## The `psychrometrics` Toolbox for Scilab

`psychrometrics` provides the following functions:

- `psychro`
- `humidity`
- `satPress`
- `enthalpy`
- `volume`
- `adiabSat`

### `psychro`

`psychro` computes the dry bulb temperature, the wet bulb temperature, the dew point temperature, the adiabatic saturation temperature, the humidit, the saturation humidity, the saturation humidity at the wet bulb temperature, the adiabatic saturation humidity, the specific enthalpy, the specific volume, the the relative humidity, the water vapor pressure, the water saturation pressure, the saturation pressure at the wet bulb temperature and the density, given any two input arguments, except for the combination of water vapor pressure and dew point temperature, which are not mutually independent. A schematic psychrometric chart can the presented as a graphical representation of the solution.

**Syntax:**

```powershell-interactive
[Tdry,Twet,Tdew,Tadiab,W,Wsat,Wsatwet,Wadiab,h,v,phi,pw,psat,psatwet,rho]=..
psychro(Tdry,Twet,Tdew,W,h,v,phi,fig)
```

**Example:**

Compute the dry bulb temperature, the wet bulb temperature, the dew point temperature, the adiabatic saturation temperature, the humidity, the saturation humidity, the saturation humidity at wet bulb temperature, the adiabatic saturation humidity, the specific enthalpy, the specific volume, the relative humidity, the water vapor pressure, the saturation pressure, the saturation pressure at wet bulb temperature and the density given the specific enthalpy is 79.5 kJ/kg and the relative humidity is 0.29 and plot a graphical representation of the answer in a schematic psychrometric chart:

```powershell-interactive
[Tdry,Twet,Tdew,Tadiab,W,Wsat,Wsatwet,Wadiab,h,v,phi,pw,psat,psatwet,rho]=..
psychro(h=79.5e3,phi=.29,fig=%t) // inputs and outputs in SI units
```

### `humidity`

`humidity` computes the humidity of humid air given the water vapor pressure and the total pressure. By default, total pressure is assumed to be the atmospheric pressure at sea level (101325 Pa).

**Syntax:**

```powershell-interactive
[W]=humidity(pw,p)
```

**Example:**

Compute the humidity of humid air at atmospheric pressure given water vapor pressure is 1 kPa at 1 atm total pressure:

```powershell-interactive
pw=1e3; // water vapor pressure in Pa
W=humidity(pw) // saturation pressure in kg/kg of dry air
```

### `satPress`

`satPress` computes the saturation pressure of humid air given the dry bulb temperature.

**Syntax:**

```powershell-interactive
[psat]=satPress(Tdry)
```

**Example:**

Compute the saturation pressure given the dry bulb temperature is 25 °C:

```powershell-interactive
Tdry=25+273.15; // dry bulb temperature in K
psat=satPress(Tdry) // saturation pressure in Pa
```

### `enthalpy`

`enthalpy` computes the specific enthalpy of humid air given the dry bulb temperature and the humidity.

**Syntax:**

```powershell-interactive
[h]=enthalpy(Tdry,W)
```

**Example:**

CCompute the specific enthalpy given the dry bulb temperature is 25 °C and the humidity is 7 g/kg of dry air:

```powershell-interactive
Tdry=25+273.15; // dry bulb temperature in K
W=7e-3; // humidity in kg/kg of dry air
h=enthalpy(Tdry,W) // specific enthalpy in J/kg of dry air
```

### `volume`

`volume` computes the specific volume of humid air given the dry bulb temperature the humidity and the total pressure. By default, total pressure is assumed to be the atmospheric pressure at sea level (101325 Pa).

**Syntax:**

```powershell-interactive
[v]=volume(Tdry,W,p)
```

**Example:**

CCompute the specific volume given the dry bulb temperature is 25 °C and the humidity is 7 g/kg of dry air at 1 atm total pressure:

```powershell-interactive
Tdry=25+273.15; // dry bulb temperature in K
W=7e-3; // humidity in kg/kg of dry air
v=volume(Tdry,W) // specific volume in cu. m/kg of dry air
```

### `adiabSat`

`adiabSat` Compute the temperature and the humidity at saturation condition given the specific enthalpy. A schematic psychrometric chart can the presented as a graphical representation of the solution.

**Syntax:**

```powershell-interactive
[Tadiab,Wadiab]=adiabSat(h,fig)
```

**Example:**

Compute the temperature and the humidity at saturation condition given the specific enthalpy 82.4 kJ/kg of dry air and plot a graphical representation of the answer in a schematic psychrometric chart:

```powershell-interactive
h=82.4e3; // enthalpy in J/kg dry air
[T,W]=adiabSat(h,%t) // inputs and outputs in SI units
```

### See Also

[Internal-Fluid-Flow-for-Scilab](https://github.com/aumpierre-unb/Internal-Fluid-Flow-for-Scilab).

Copyright &copy; 2023 Alexandre Umpierre

email: aumpierre@gmail.com
