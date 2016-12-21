module matplotlibd.pycall;

package:
void python_call(string python_path, string script) {
    import std.process : pipeProcess, wait, Redirect;
    auto pipes = pipeProcess(python_path, Redirect.stdin | Redirect.stderr);

    pipes.stdin.writeln(script);
    pipes.stdin.writeln("exit()");
    pipes.stdin.close();

    wait(pipes.pid);

    string error;
    foreach (line; pipes.stderr.byLine)
        error ~= line ~ "\n";

    if (error)
        throw new Exception("\n\nERROR occurred in Python:\n" ~ error);
}
