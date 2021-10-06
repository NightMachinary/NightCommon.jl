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
##
