-module(p13).
-export([decode/1]).

decode(List) ->
	p05:reverse(decode(List, [])).

decode([{1, Head} | Tail], Acc) ->
	decode(Tail, [Head | Acc]);
decode([{Count, Head} | Tail], Acc) ->
	decode([{Count - 1, Head} | Tail], [Head | Acc]);
decode([], Acc) ->
	Acc.