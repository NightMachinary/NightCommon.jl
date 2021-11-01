##
macro comment(args...) end
export @comment
##
macro copycode(name, definition)
    # @def insertme some_code...
    # @insertme => would insert some_code... here
    # from http://www.stochasticlifestyle.com/type-dispatch-design-post-object-oriented-programming-julia/
  return quote
      macro $(esc(name))()
          esc($(Expr(:quote, definition)))
      end
  end
end
export @copycode
##
# From: good macros here https://gist.github.com/MikeInnes/8299575

# Equivalent to @time @dotimes ... Consider using @benchmark.

# Repeat an operation n times, e.g.
# @dotimes 100 println("hi")

# macro dotimes(n, body)
#     quote
#         for i = 1:$(esc(n))
#             $(esc(body))
#         end
#     end
# end
# export @dotimes

# macro dotimed(n, body)
#   :(@time @dotimes $(esc(n)) $(esc(body)))
# end
# export @dotimed

# Stop Julia from complaining about redifined consts/types -
# @defonce type MyType
#   ...
# end
# or
# @defonce const pi = 3.14

# macro defonce(typedef::Expr)
#   if typedef.head == :type
#     name = typedef.args[2]
#   elseif typedef.head == :typealias || typedef.head == :abstract
#     name = typedef.args[1]
#   elseif typedef.head == :const
#     name = typedef.args[1].args[1]
#   else
#     error("@defonce called with $(typedef.head) expression")
#   end
# export @defonce

#   typeof(name) == Expr && (name = name.args[1]) # Type hints

#   :(if !isdefined(@__MODULE__, $(Expr(:quote, name)))
#       $(esc(typedef))
#     end)
# end

# Julia's do-while loop, e.g.
# @once_then while x < 0.5
#   x = rand()
# end

macro once_then(expr::Expr)
    @assert expr.head == :while
    esc(quote
            $(expr.args[2]) # body of loop
            $expr # loop
        end)
end
export @once_then

function memoize(f)
    cache = Dict()
    (args...) -> haskey(cache, args) ? cache[args] : (cache[args] = f(args...))
end
export @memoize

# Evaluate expressions at compile time, e.g.
# hard_calculation(n) = (sleep(1); n)
# f(x) = x * @preval hard_calculation(2) # takes 1 second
# f(2) => 4 # instant

"Force the input expression to be evaluated in compile-time"
macro preval(expr)
    eval(expr)
end
export @preval

# Speed up anonymous functions 10x
# @dotimed 10^8 (x -> x^2)(rand()) # 3.9 s
# @dotimed 10^8 (@fn x -> x^2)(rand()) # 0.36 s

macro fn(expr::Expr)
    @assert expr.head in (:function, :->)
    name = gensym()
    args = expr.args[1]
    args = typeof(args) == Symbol ? [args] : args.args
    body = expr.args[2]
    @eval $name($(args...)) = $body
    name
end
export @fn
##
