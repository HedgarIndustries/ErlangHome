-module(p12).
-export([decode_modified/1]).

decode_modified(List) ->
	p05:reverse(decode_modified(List, [])).

decode_modified([{1, Head} | Tail], Acc) ->
	decode_modified(Tail, [Head | Acc]);
decode_modified([{Count, Head} | Tail], Acc) ->
	decode_modified([{Count - 1, Head} | Tail], [Head | Acc]);
decode_modified([Head | Tail], Acc) ->
	decode_modified(Tail, [Head | Acc]);
decode_modified([], Acc) ->
	Acc.