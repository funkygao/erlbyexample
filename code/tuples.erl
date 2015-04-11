-module(tuples).
-export([convert/1]).

%% tuples are surrounded by { and }.
%% Usage: convert({k, 5}).
convert({k, X}) -> {b, 1024*X};
convert({m, X}) -> {b, 1024*1024*X}.

