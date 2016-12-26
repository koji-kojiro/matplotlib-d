# matplotlib-d

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Build Status](https://travis-ci.org/koji-kojiro/matplotlib-d.svg?branch=master)](https://travis-ci.org/koji-kojiro/matplotlib-d)
[![Dub version](https://img.shields.io/dub/v/matplotlib-d.svg)](https://code.dlang.org/packages/matplotlib-d)
[![Dub download](https://img.shields.io/dub/dt/matplotlib-d.svg)](https://code.dlang.org/packages/matplotlib-d)

2D Plotting library for D using python and matplotlib.  

## Requirements
- Python
- matplotlib

## Usage
### Installation
To use this package, put the following dependency into your project's dependencies section:  

dub.json: `"matplotlib-d": "~>0.1.4"`  
dub.sdl: `dependency "matplotlib-d" version="~>0.1.4"`  


For small applications or scripts, add following sentence to the head of your script.  
```d
#!/usr/bin/env dub
/+ dub.sdl:
	name "name_of_your_application"
	dependency "matplotlib-d" version="~>0.1.4"
+/
```
And excute with `dub run --single`.  
For more details, please refer to [the documentation of dub](https://code.dlang.org/getting_started).  

### Syntax
Most pyplot functions are avilable.  
For more details for each functions, please refer to the [documantation of pyplot](http://matplotlib.org/api/pyplot_summary.html).  
Describe Python keyword arguments as an associative array with string of keyword name as key.  

- The Python way:  
*function(arg1, arg2..., keyword1=kwarg1, keyword2=kwarg2...)*  
- The D way:  
*function(arg1, arg2..., ["keyword1": kwarg1], ["keyword2": kwarg2])*  


## Examples

Simple example:
```d
import std.math;
import std.range;
import std.algorithm;
import plt = matplotlibd.pyplot;

void main() {
	auto x = iota(0, 2.05, 0.05).map!(x => x * PI);
	auto y = x.map!(sin);

	plt.plot(x, y, "r-", ["label": "$y=sin(x)$"]);
	plt.xlim(0, 2 * PI);
	plt.ylim(-1, 1);
	plt.legend();
	plt.savefig("simple.png");
	plt.clear();
}
```
![Simple example](./examples/simple.png)

Color plot example:

```d
import std.range;
import plt = matplotlibd.pyplot;

void main() {
	const n = 100;
	auto x = iota(n);
	auto y = x[];
	double[n][n] z;
		
	foreach (i; 0..n)
		foreach (j; 0..n)
			z[i][j] = i + j;
	    
	plt.contourf(x, y, z, 64, ["cmap": "hsv"]);
	plt.colorbar();
	plt.savefig("color.png");
	plt.clear();
}
```
![Color plot example](./examples/color.png)
