-module(bs04).
-import(p05, [reverse/1]).
-export([decode_xml/1]).

%% Main
decode_xml(XML) ->
	reassemble(disassemble(XML)).


%% +Acc
reassemble(Parts) ->
	p05:reverse(reassemble(Parts, [])).

%% Simple block -> push to Acc and proceed with Tail
reassemble([{H1, open}, {H2, value}, {_, close} | Tail], Acc) ->
	reassemble(Tail, [{H1, [], H2} | Acc]);

%% Inner block detected -> dive into and extract the reached Tail, go further with that Tail
reassemble([{H1, open}, {H2, open} | Tail], Acc) ->
	{Rest, Result} = reassemble([{H2, open} | Tail], []),
	reassemble(Rest, [{H1, [], Result} | Acc]);

%% End of recursive block -> return reached Tail and reversed Acc
reassemble([{_, close} | Tail], Acc) ->
	{Tail, p05:reverse(Acc)};

%% Empty list -> return Acc
reassemble([], Acc) ->
	Acc.


%% +Acc
disassemble(XML) ->
	p05:reverse(disassemble(XML, [])).

%% XML string -> binary words with a type atom
disassemble(<<_, _/binary>> = XML, Parts) ->
	{Type, Rest, Part} = determine(undef, XML, <<>>),
	disassemble(Rest, [{Part, Type} | Parts]);

%% End of XML -> return the list of words
disassemble(<<>>, Parts) ->
	Parts.


%% An escape symbol -> proceed
determine(Type, <<$\\, Head, Rest/binary>>, Part) ->
	determine(Type, Rest, <<Part/binary, Head>>);

%% An ordinar symbol -> proceed
determine(Type, <<Head, Rest/binary>>, Part) when Head /= $<, Head /= $> ->
	determine(Type, Rest, <<Part/binary, Head>>);

%% Closing tag detected -> set type atom to 'close'
determine(undef, <<$<, $/, Rest/binary>>, <<>>) ->
	determine(close, Rest, <<>>);

%% Opening tag detected -> set type atom to 'open'
determine(undef, <<$<, Rest/binary>>, <<>>) ->
	determine(open, Rest, <<>>);

%% End of value field -> return with type 'value'
determine(undef, <<$<, _/binary>> = XML, Part) ->
	{value, XML, Part};

%% End of tag -> return
determine(Type, <<$>, Rest/binary>>, Part) ->
	{Type, Rest, Part};

%% End of XML -> return
determine(close, <<>>, _) ->
	{close, <<>>, <<>>}.