-module(p07).
-export([flatten/1]).

flatten(List) ->
	p05:reverse(flatten(List, [])).

flatten([[Head2 | Tail2] | Tail], Acc) ->
	flatten([Head2, Tail2 | Tail], Acc);
flatten([[] | Tail2], Acc) ->
	flatten(Tail2, Acc);
flatten([Head | Tail], Acc) ->
	flatten(Tail, [Head | Acc]);
flatten([], Acc) ->
	Acc.