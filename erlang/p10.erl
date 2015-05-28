-module(p10).
-export([encode/1]).

encode(List) ->
	encode(List, 0, []).

encode([], _, Acc) ->
	p05:reverse(Acc);
encode([Head, Head | Tail], Counter, Acc) ->
	encode([Head | Tail], Counter + 1, Acc);
encode([Head | Tail], Counter, Acc) ->
	encode(Tail, 0, [{Counter + 1, Head} | Acc]).