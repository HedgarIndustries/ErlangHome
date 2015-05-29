-module(p05).
-export([reverse/1]).

reverse(List) ->
	reverse(List, []).

reverse([Head | Tail], Acc) ->
	reverse(Tail, [Head | Acc]);
reverse([], Acc) ->
	Acc.