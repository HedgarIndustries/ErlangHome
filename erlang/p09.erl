-module(p09).
-export([pack/1]).

pack(List) ->
	pack(List, [], []).

pack([], _, Acc) ->
	p05:reverse(Acc);
pack([Head, Head | Tail], Acc2, Acc) ->
	pack([Head | Tail], [Head | Acc2], Acc);
pack([Head | Tail], Acc2, Acc) ->
	pack(Tail, [], [[Head | Acc2] | Acc]).