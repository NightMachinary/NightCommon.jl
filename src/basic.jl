##
function getdict(;kwargs...)
    return kwargs
end
export getdict
##
function sa(x)
    show(IOContext(stdout, :limit=>false), MIME"text/plain"(), x)
    println()
end
export sa

function ec(x)
    println(x)
end
export ec

function sad(x)
    # ec density
    sa(prop(freqtable(x)))
end
export sad
##
