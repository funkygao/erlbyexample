%% Distributed ping/pong
%%
%% Usage:
%% node1>erl -sname ping
%% node1.erl>dping:start_ping(pong@mac).

%%
%% node2>erl -sname pong
%% node2.erl>dping:start_pong().

-module(dping).
-export([start_ping/1, start_pong/0, ping/2, pong/0]).

ping(0, PongNode) ->
    {pong, PongNode} ! finished,
    io:format("ping finished~n", []);
ping(N, PongNode) ->
    {pong, PongNode} ! {ping, self()},
    receive
        pong ->
            io:format("Ping received pong~n", [])
    end,
    ping(N-1, PongNode).

pong() ->
    receive
        finished ->
            io:format("pong finished~n", []);
        {ping, PingPid} ->
            io:format("Pong received ping from ~w~n", [PingPid]),
            PingPid ! pong,
            pong()
    end.

start_pong() ->
    register(pong, spawn(dping, pong, [])).

start_ping(PongNode) ->
    spawn(dping, ping, [5, PongNode]).

