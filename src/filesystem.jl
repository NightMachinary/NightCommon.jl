##
ensureDir(dest) = mkpath(dirname(dest))
export ensureDir
##
pathExtract(path::AbstractString)::RegexMatch = match(r"(.*/)?(([^/]*?)(?:\.([^.]+))?)$", path)
export pathExtract

fileNameNoExt(path::AbstractString) = pathExtract(path)[3]
export fileNameNoExt
##
