-module(p04).
-export([len/1]).

len(List) ->
	len(List, 0).

len([], Counter) ->
	Counter;
len([_ | Tail], Counter) ->
	len(Tail, Counter + 1).