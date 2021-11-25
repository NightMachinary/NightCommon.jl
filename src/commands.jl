##
function outrs(cmd::Cmd)
    @> cmd read(String) chomp
end
export outrs
##
function runi(cmd ; kwargs...)
    run(ignorestatus(cmd) ; kwargs...)
end
export runi

function runbool(args... ; kwargs...)
    runi(args... ; kwargs...).exitcode == 0
end
runb = runbool
export runbool
export runb
##
