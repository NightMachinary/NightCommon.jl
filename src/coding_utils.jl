##
macro currentFuncName()
    # Using `local` is optional, but it makes the code more readable
    return quote
        local st = stacktrace(backtrace())
        local myf = ""
        for frm in st
            funcname = frm.func
            if frm.func != :backtrace && frm.func!= Symbol("macro expansion")
                myf = frm.func
                break
            end
        end
        replace(string(myf), r"#?([^#]*)#?.*" => s"\1")
    end
end
export @currentFuncName

macro codeLocation()
    # From https://discourse.julialang.org/t/how-to-print-function-name-and-source-file-line-number/43486/4
    return quote
        "Running function " * $("$(__module__)") * ".$(@currentFuncName) at " * $("$(__source__.file)") * ":" * $("$(__source__.line)")
    end
end
export @codeLocation
##
