macro labeled(body)
    # @alt `Base.@show' does essentially the same thing
    ##
    bodystr = string(body)
    quote
        out = $(esc(body))
        res = @> map(split(string(out),"\n")) do line
            "\t$line"
        end join("\n")
        println("$($bodystr) =>$(res)")
        out
    end
end
export @labeled
