using REPL

is_continous_bell = false
bell_single_threshold_seconds = 10
bell_continuous_threshold_seconds = 60

cmd_start_time = time() # to avoid buzzing on reloadStartup

function repl_pre()
    global is_continous_bell
    global cmd_start_time = time() # Get the system time in seconds since the epoch
    if is_continous_bell
        okj()
        is_continous_bell = false
    end
end

function repl_post()
    global cmd_start_time
    global is_continous_bell
    dur = time() - cmd_start_time
    if dur >= bell_continuous_threshold_seconds
        bellj()
        is_continous_bell = true
    elseif dur >= bell_single_threshold_seconds
        bello()
    end
end

function repl_transform_prepost(ex)
    res_sym = gensym("res_sym") # the string will be included in the name, helpful for debugging?
    Expr(:toplevel, :($repl_pre()), :($res_sym = $ex),:($repl_post()),:($res_sym))
    # * Wouldn't using =$(esc(ex))= be better?
    # ** No. See [[id:1f926185-b593-480c-b6a7-f2ec5ed4ab5d][macros/hygiene]]
end

if ! @isdefined BELL_LOADED
    if isdefined(Base, :active_repl_backend)
        if VERSION >= v"1.5.0-DEV.282"
            pushfirst!(Base.active_repl_backend.ast_transforms, repl_transform_prepost)
        else
            # Unsupported
        end
    elseif isdefined(Main, :IJulia)
        # @untested
        Main.IJulia.push_preexecute_hook(repl_pre)
        Main.IJulia.push_postexecute_hook(repl_post)
    elseif VERSION >= v"1.5.0-DEV.282"
        pushfirst!(REPL.repl_ast_transforms, repl_transform_prepost)
    end
end
const BELL_LOADED = true
