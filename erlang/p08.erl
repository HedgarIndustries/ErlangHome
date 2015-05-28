-module(p08).
-export([compress/1]).

compress(List) ->
	p05:reverse(compress(List, [])).

compress([Head, Head | Tail], Acc) ->
	compress([Head | Tail], Acc);
compress([Head | Tail], Acc) ->
	compress(Tail, [Head | Acc]);
compress([], Acc) ->
	Acc.