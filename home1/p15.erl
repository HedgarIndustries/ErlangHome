-module(p15).
-export([replicate/2]).

replicate(_, 0) ->
	[];
replicate(List, Times) ->
	p05:reverse(replicate(List, {Times, Times}, [])).

replicate([Head | Tail], {1, Times}, Acc) ->
	replicate(Tail, {Times, Times}, [Head | Acc]);
replicate([Head | Tail], {Count, Times}, Acc) ->
	replicate([Head | Tail], {Count - 1, Times}, [Head | Acc]);
replicate([], {_, _}, Acc) ->
	Acc.