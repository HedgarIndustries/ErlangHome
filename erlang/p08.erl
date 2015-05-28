-module(p08).
-export([compress/1]).

compress(List) ->
	compress(List, []).

compress([], Acc) ->
	p05:reverse(Acc);
compress([Head, Head | Tail], Acc) ->
	compress([Head | Tail], Acc);
compress([Head | Tail], Acc) ->
	compress(Tail, [Head | Acc]).