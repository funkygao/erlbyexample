-module(ping).
-export([start/0, ping/2, pong/0]).

ping(0, PongPid) ->
    PongPid ! finished,
    io:format("ping finished~n", []);
ping(N, PongPid) ->
    PongPid ! {ping, self()},
    receive 
        pong ->
            io:format("Ping received pong~n", [])
    end,
    ping(N-1, PongPid).

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
    PongPid = spawn(ping, pong, []),
    spawn(ping, ping, [5, PongPid]).

