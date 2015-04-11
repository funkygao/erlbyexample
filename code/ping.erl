-module(ping).
-export([start/0, ping/1, pong/0]).

ping(0) ->
    pong ! finished,
    io:format("ping finished~n", []);
ping(N) ->
    pong ! {ping, self()},
    receive 
        pong ->
            io:format("Ping received pong~n", [])
    end,
    ping(N-1).

pong() ->
    receive
        finished ->
            io:format("Pong finished~n", []);
        {ping, PingPid} ->
            io:format("Pong received ping~n", []),
            PingPid ! pong,
            pong()
    end.

start() ->
    register(pong, spawn(ping, pong, [])),
    ping(3).

