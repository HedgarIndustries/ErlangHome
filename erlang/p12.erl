-module(p12).
-export([decode_modified/1]).

decode_modified(List) ->
	decode_modified(List, []).

decode_modified([], Acc) ->
	p05:reverse(Acc);
decode_modified([{1, Head} | Tail], Acc) ->
	decode_modified(Tail, [Head | Acc]);
decode_modified([{Count, Head} | Tail], Acc) ->
	decode_modified([{Count - 1, Head} | Tail], [Head | Acc]);
decode_modified([Head | Tail], Acc) ->
	decode_modified(Tail, [Head | Acc]).