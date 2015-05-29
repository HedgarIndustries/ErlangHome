-module(p10).
-export([encode/1]).

encode(List) ->
	p05:reverse(encode(List, 0, [])).

encode([Head, Head | Tail], Counter, Acc) ->
	encode([Head | Tail], Counter + 1, Acc);
encode([Head | Tail], Counter, Acc) ->
	encode(Tail, 0, [{Counter + 1, Head} | Acc]);
encode([], _, Acc) ->
	Acc.