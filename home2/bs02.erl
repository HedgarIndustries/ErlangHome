-module(bs02).
-export([words/1]).
-import(../p05, [reverse/1]).

words(Text) ->
	p05:reverse(words(Text, <<>>, [])).

words(<<" ", Rest/binary>>, Word, Sentence) ->
	words(Rest, <<>>, [Word | Sentence]);
words(<<Head, Rest/binary>>, Word, Sentence) ->
	words(Rest, <<Word/binary, Head>>, Sentence);
words(<<>>, Word, Sentence) ->
	[Word | Sentence].