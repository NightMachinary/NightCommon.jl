# bello() = runi(`brishz.dash redo2 2 bell-greencase`, wait=false)
bello() = runi(`brishz.dash awaysh bello`, wait=false)
export bello

bellj() = runi(`brishz.dash awaysh bellj`, wait=false)
export bellj

bella() = runi(`brishz.dash awaysh bella`, wait=false)
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
