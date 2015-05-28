-module(p09).
-export([pack/1]).

pack(List) ->
	p05:reverse(pack(List, [], [])).

pack([Head, Head | Tail], Acc2, Acc) ->
	pack([Head | Tail], [Head | Acc2], Acc);
pack([Head | Tail], Acc2, Acc) ->
	pack(Tail, [], [[Head | Acc2] | Acc]);
pack([], _, Acc) ->
	Acc.