# matplotlib-d

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Build Status](https://travis-ci.org/koji-kojiro/matplotlib-d.svg?branch=master)](https://travis-ci.org/koji-kojiro/matplotlib-d)
<a href="https://code.dlang.org/packages/matplotlib-d" title="Go to matplotlib-d"><img src="https://img.shields.io/dub/v/matplotlib-d.svg" alt="Dub version"></a>

A simple interface to pyplot for D.
## Requirements
- Python
- matplotlib

## Build
```
$ cd matplotlib-d
$ dub build --build=release
```

## Usage
To use this package, put the following dependency into your project's dependencies section:  
dub.json: `"matplotlib-d": "~>0.1.0"`  
dub.sdl: `dependency "matplotlib-d" version="~>0.1.0"`  

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

import std.range;
import plt = matplotlibd.pyplot;
```d
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
