-module(p01).
-export([last/1]).

last([Head]) ->
	Head;
last([_ | Tail]) ->
	last(Tail).