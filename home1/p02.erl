-module(p02).
-export([but_last/1]).

but_last([Head, SubHead]) ->
	[Head, SubHead];
but_last([_ | Tail]) ->
	but_last(Tail).