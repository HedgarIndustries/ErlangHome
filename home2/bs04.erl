-module(bs04).
-import(p05, [reverse/1]).
-export([decode_xml/1]).

%% Main
decode_xml(XML) ->
	reassemble(disassemble(XML)).


%% +Acc
reassemble(Parts) ->
	p05:reverse(reassemble(Parts, [])).

%% End of recursive block -> return reached Tail and reversed Acc
reassemble([{_, close} | Tail], Acc) ->
	{Tail, p05:reverse(Acc)};

%% Inner block detected -> dive into and extract the reached Tail, go further with that Tail
reassemble([{H1, open}, {H2, open} | Tail], Acc) ->
	{Rest, Result} = reassemble([{H2, open} | Tail], []),
	reassemble(Rest, [{H1, [], Result} | Acc]);

%% Simple block -> push to Acc and proceed with Tail
reassemble([{H1, open}, {H2, value}, {_, close} | Tail], Acc) ->
	reassemble(Tail, [{H1, [], H2} | Acc]);

%% Empty list -> return Acc
reassemble([], Acc) ->
	Acc.


%% +Acc
disassemble(XML) ->
	p05:reverse(disassemble(XML, [])).

%% XML string -> binary words with a type atom
disassemble(<<_, _/binary>> = XML, Parts) ->
	{Rest, Part, Type} = determine(XML, <<>>, open),
	disassemble(Rest, [{Part, Type} | Parts]);

%% End of XML -> return the list of words
disassemble(<<>>, Parts) ->
	Parts.


%% Closing tag detected -> set type atom to 'close'
determine(<<"</", Rest/binary>>, <<>>, _) ->
	determine(Rest, <<>>, close);

%% Opening tag detected -> set type atom to 'open'
determine(<<"<", Rest/binary>>, <<>>, _) ->
	determine(Rest, <<>>, open);

%% End of value field -> return with type 'value'
determine(<<"<", _/binary>> = XML, Part, _) ->
	{XML, Part, value};

%% End of tag -> return
determine(<<">", Rest/binary>>, Part, Type) ->
	{Rest, Part, Type};

%% An ordinar symbol -> proceed
determine(<<Head, Rest/binary>>, Part, Type) ->
	determine(Rest, <<Part/binary, Head>>, Type);

%% End of XML -> return
determine(<<>>, Part, close) ->
	{<<>>, Part, close}.