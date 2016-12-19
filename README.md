# matplotlib-d

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

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
Add `matplotlib-d` to your dub project.  
Simple example:

```D:
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

```D:
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
