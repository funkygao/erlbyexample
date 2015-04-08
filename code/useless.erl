-module(useless).
-export([add/2, minus/2, hello/0]).
-import(io, [format/1]).

add(M, N) -> 
    M+N.

minus(M, N) -> 
    M-N.

hello() ->
    format("Hello world~n").
