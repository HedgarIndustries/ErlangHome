-module(p11).
-export([encode_modified/1]).

encode_modified(List) ->
	p05:reverse(encode_modified(List, 0, [])).

encode_modified([Head, Head | Tail], Counter, Acc) ->
	encode_modified([Head | Tail], Counter + 1, Acc);
encode_modified([Head | Tail], 0, Acc) ->
	encode_modified(Tail, 0, [Head | Acc]);
encode_modified([Head | Tail], Counter, Acc) ->
	encode_modified(Tail, 0, [{Counter + 1, Head} | Acc]);	
encode_modified([], _, Acc) ->
	Acc.