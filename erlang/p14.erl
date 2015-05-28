-module(p14).
-export([duplicate/1]).

duplicate(List) ->
	duplicate(List, []).

duplicate([], Acc) ->
	p05:reverse(Acc);
duplicate([Head | Tail], Acc) ->
	duplicate(Tail, [Head, Head | Acc]).