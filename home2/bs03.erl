-module(bs03).
-import(p05, [reverse/1]).
-export([split/2]).

%% Text, Delimiter
split(<<>>, _) ->
	<<>>;
split(T, <<>>) ->
	T;
split(T, D) ->
	p05:reverse(split(T, {D, D}, {<<>>, <<>>}, [])).

%% T  = text
%% TF = text first
%% TR = text rest
%% TW = text word
%% D  = delimiter
%% DF = delimiter first
%% DR = delimiter rest
%% DW = delimiter word
%% S  = result sentence

%% Buffer word if delimiter have not been touched
split(<<TF, TR/binary>>, {<<DF, _/binary>> = D, D}, {TW, _}, S) when TF /= DF ->
	split(TR, {D, D}, {<<TW/binary, TF>>, <<>>}, S);

%% Append wrong delimiter part to the word, restore delimiter, remain the main binary untouched
split(<<TF, _/binary>> = T, {<<DF, _/binary>>, D}, {TW, DW}, S) when TF /= DF ->
	split(T, {D, D}, {<<TW/binary, DW/binary>>, <<>>}, S);

%% If delimiter is not empty, buffer it in order to pushing into the word if delimiter is wrong
split(<<TF, TR/binary>>, {<<TF, DR/binary>>, D}, {TW, DW}, S) ->
	split(TR, {DR, D}, {TW, <<DW/binary, TF>>}, S);

%% If delimiter is empty, append a word buffered before detecting delimiter
split(T, {<<>>, D}, {TW, _}, S) ->
	split(T, {D, D}, {<<>>, <<>>}, [TW | S]);
	
%% Append the last word and return
split(<<>>, {_, _}, {TW, DW}, S) ->
	[<<TW/binary, DW/binary>> | S].