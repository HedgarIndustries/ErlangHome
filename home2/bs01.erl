-module(bs01).
-export([first_word/1]).

first_word(Text) ->
	first_word(Text, <<>>).

first_word(<<" ", _/binary>>, Acc) ->
	Acc;
first_word(<<Head, Rest/binary>>, Acc) ->
	first_word(Rest, <<Acc/binary, Head>>);
first_word(<<>>, Acc) ->
	Acc.