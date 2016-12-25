module matplotlibd.pyplot;
import matplotlibd.core.pycall;
import matplotlibd.core.translate;

private:

string py_script = "import matplotlib.pyplot as plt\n";

immutable string py_methods = (){
    import std.string: splitLines;

    string[] method_names = import("pyplot_functions.txt").splitLines;
    string py_methods;

    foreach(name; method_names) {
        py_methods ~=
            "void " ~ name ~ "(T...)(T a)" ~
            "{import std.format: format;" ~
            "string p;if(a.length>0){foreach(i;a){p~=parseArgs(i);}" ~
            "p = p[0..$-1];}py_script~=format(\"plt."~ name ~ "(%s)\n\",p);";

        if (name == "show" || name == "savefig")
            py_methods ~= "call(py_script);}\n";
        else
            py_methods ~= "}\n";
    }

    return py_methods;
}();

public:
import matplotlibd.core.translate: False, True, None;

void clear() {
    py_script = "import matplotlib.pyplot as plt\n";
}

mixin(py_methods);

unittest {
    auto script = py_script ~ "plt.figure(figsize=[4, 4])\n";
    figure(["figsize": [4, 4]]);
    assert(py_script == script);
}
