-module(p14).
-export([duplicate/1]).

duplicate(List) ->
	p05:reverse(duplicate(List, [])).

duplicate([Head | Tail], Acc) ->
	duplicate(Tail, [Head, Head | Acc]);
duplicate([], Acc) ->
	Acc.