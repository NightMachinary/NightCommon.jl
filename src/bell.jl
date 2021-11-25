# bello() = runi(`brishz.dash redo2 2 bell-greencase`, wait=false)
bello() = runi(`brishz.dash awaysh bello`, wait=false)
export bello

bellj() = runi(`brishz.dash awaysh bellj`, wait=false)
export bellj

function bella(host=nothing)
    if host === nothing ||
        (host == :mbp && mbpP())
        runi(`brishz.dash awaysh bella`, wait=false)
    end
end
export bella

okj() = runi(`brishz.dash awaysh okj`, wait=false)
export okj

function firstbell()
    if ! @isdefined firstLoad
        bellj()
    else
        bello()
    end
    global firstLoad = true
end
export firstbell
