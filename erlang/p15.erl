-module(p15).
-export([replicate/2]).

replicate(List, Times) ->
	replicate(List, Times, Times, []).

replicate([], _, _, Acc) ->
	p05:reverse(Acc);
replicate([Head | Tail], Times, 1, Acc) ->
	replicate(Tail, Times, Times, [Head | Acc]);
replicate([Head | Tail], Times, Count, Acc) ->
	replicate([Head | Tail], Times, Count - 1, [Head | Acc]).