module matplotlibd.pyplot;

private:

string py_path = "python";
string py_script = "import matplotlib.pyplot as plt\n";

immutable string[] method_names =
    ["Annotation", "Arrow", "Artist", "AutoLocator", "Axes", 
     "Button", "Circle", "Figure", "FigureCanvasBase", "FixedFormatter", 
     "FixedLocator", "FormatStrFormatter", "Formatter", "FuncFormatter", 
     "GridSpec", "IndexLocator", "Line2D", "LinearLocator", "Locator", 
     "LogFormatter", "LogFormatterExponent", "LogFormatterMathtext", 
     "LogLocator", "MaxNLocator", "MultipleLocator", "Normalize", 
     "NullFormatter", "NullLocator", "PolarAxes", "Polygon", 
     "Rectangle", "ScalarFormatter", "Slider", "Subplot", "SubplotTool", 
     "Text", "TickHelper", "Widget", "acorr", "angle_spectrum", "annotate",
     "arrow", "autoscale", "autumn", "axes", "axhline", "axhspan", "axis",
     "axvline", "axvspan", "bar", "barbs", "barh", "bone", "box", "boxplot", 
     "broken_barh", "cla", "clabel", "clf", "clim", "close", 
     "cohere", "colorbar", "colormaps", "colors", "connect", "contour",
     "contourf", "cool", "copper", "csd", "cycler", "dedent", "delaxes",
     "disconnect", "draw", "draw_all", "draw_if_interactive", 
     "errorbar", "eventplot", "figaspect", "figimage", "figlegend", 
     "fignum_exists", "figtext", "figure", "fill", "fill_between", 
     "fill_betweenx", "findobj", "flag", "gca", "gcf", "gci", 
     "get", "get_backend", "get_cmap", "get_current_fig_manager", 
     "get_figlabels", "get_fignums", "get_plot_commands", "get_scale_docs", 
     "get_scale_names", "getp", "ginput", "gray", "grid", "hexbin", 
     "hist", "hist2d", "hlines", "hold", "hot", "hsv", "imread", 
     "imsave", "imshow", "inferno", "install_repl_displayhook", 
     "interactive", "ioff", "ion", "is_numlike", "is_string_like", 
     "ishold", "isinteractive", "jet", "legend", "locator_params", 
     "loglog", "magma", "magnitude_spectrum", "margins", "matshow", 
     "minorticks_off", "minorticks_on", "new_figure_manager", 
     "over", "pause", "pcolor", "pcolormesh", "phase_spectrum", 
     "pie", "pink", "plasma", "plot", "plot_date", "plotfile", 
     "plotting", "polar", "prism", "psd", "pylab_setup", "quiver", 
     "quiverkey", "rc", "rc_context", "rcdefaults", "register_cmap", 
     "rgrids", "savefig", "sca", "scatter", "sci", "semilogx", 
     "semilogy", "set_cmap", "setp", "show", "silent_list", "specgram", 
     "spectral", "spring", "spy", "stackplot", "stem", "step", 
     "streamplot", "subplot", "subplot2grid", "subplot_tool", 
     "subplots", "subplots_adjust", "summer", "suptitle", "switch_backend", 
     "table", "text", "thetagrids", "tick_params", "ticklabel_format", 
     "tight_layout", "title", "tricontour", "tricontourf", "tripcolor", 
     "triplot", "twinx", "twiny", "uninstall_repl_displayhook", 
     "violinplot", "viridis", "vlines", "waitforbuttonpress", 
     "winter", "xcorr", "xkcd", "xlabel", "xlim", "xscale", "xticks", 
     "ylabel", "ylim", "yscale", "yticks"];
    
immutable string py_methods = (){
    string py_methods;
    foreach(name; method_names) {
        py_methods ~=
            "void " ~ name ~ "(T...)(T a)" ~
            "{import std.format: format;" ~
            "string p;if(a.length>0){foreach(i;a){p~=parseArgs(i);}" ~
            "p = p[0..$-1];}send(format(\"plt."~ name ~ "(%s)\n\",p));";

        if (name == "show" || name == "savefig")
            py_methods ~= "eval();}\n";
        else
            py_methods ~= "}\n";
    }
    return py_methods;
}();

template GenPyMethods() {
    const char[] GenPyMethods = py_methods;
}

void eval() {
    import std.process: pipeProcess, wait, Redirect;
    auto pipes = pipeProcess(py_path, Redirect.stdin | Redirect.stderr);

    pipes.stdin.writeln(py_script);
    pipes.stdin.writeln("exit()");
    pipes.stdin.close();

    wait(pipes.pid);

    string error;
    foreach (line; pipes.stderr.byLine)
        error ~= line ~ "\n";

    if (error)
        throw new Exception("\n\nERROR occurred in Python:\n" ~ error);
}

void send(string line) {
    py_script ~= line;
}

string d2py(T)(T v) {
    import std.format: format;
    static if (is(typeof(v) : PyNone))
        return "None";

    else static if (is(typeof(v) : bool))
        return v ? "True" : "False";        

    else static if (is(typeof(v) : string))
        return format("\"%s\"", v);

    else
        return format("%s", v);
}

string parseArgs(Args)(Args args) {
    static if (is(typeof(args.keys) : string[])) {
        string parsed;
        foreach(key; args.byKey)
            parsed ~= key ~ "=" ~  d2py(args[key]) ~ ",";
    }
    else
        string parsed =  d2py(args) ~ ",";
    return parsed;
}

public:

alias immutable bool PyBool;
alias immutable (void*) PyNone;

PyBool False = false;
PyBool True = true;
PyNone None = null;

void setPythonPath(string path) {
    py_path = path;
}

void clear() {
    py_script = "import matplotlib.pyplot as plt\n";
}

mixin(GenPyMethods!());

unittest {
    auto script = py_script ~ "plt.figure(figsize=[4, 4])\n";
    figure(["figsize": [4, 4]]);
    assert(py_script == script);
}
