import std.math;
import std.range;
import std.random;
import std.algorithm;
import plt = pyplotd;

void main() {
    simple();
    polar();
    subplots();
}

void simple() {
    auto x = iota(0, 2 * PI + 0.05, 0.05);
    auto y = x.map!(sin);
    
    plt.plot(x, y);
    plt.xlim(0, 2 * PI);
    plt.ylim(-1, 1);
    plt.savefig("simple.png");
}

void subplots() {
    auto x = iota(0, 2 * PI + 0.05, 0.05);

    plt.subplot(221);
    plt.plot(x, x.map!(sin));
    plt.xlim(0, 2 * PI);
    plt.ylim(-1, 1);

    plt.subplot(222);
    plt.plot(x, x.map!(cos));
    plt.xlim(0, 2 * PI);
    plt.ylim(-1, 1);

    plt.subplot(223);
    plt.plot(x, x.map!(i => sin(i) * exp(-0.4 * i)));
    plt.xlim(0, 2 * PI);
    plt.ylim(-1, 1);

    plt.subplot(224);
    plt.plot(x, x.map!(i => cos(i) * exp(-0.4 * i)));
    plt.xlim(0, 2 * PI);
    plt.ylim(-1, 1);

    plt.savefig("subplots.png");
}

void polar() {
    
    auto r = iota(0, 1.001, 0.001);
    auto theta = r.map!(i => i * 32 * PI);
    auto area = r.map!(i => i * 2000);
    
    plt.subplot(111, ["projection": "polar"]);
    plt.scatter(theta, r, ["c": r], ["s": area], ["cmap": "hsv"], ["alpha": 0.25]);
    plt.savefig("polar.png");
}

