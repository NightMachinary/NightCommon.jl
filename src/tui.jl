hsep(io::IO, c='-') = println(io, repeat(c, 40))
export hsep
hsep(args...; kwargs...) = hsep(stdout::IO, args...; kwargs...)
