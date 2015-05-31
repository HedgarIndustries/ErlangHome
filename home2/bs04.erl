-module(bs04).
-import(p05, [reverse/1]).
-export([decode_xml/1]).

decode_xml(XML) ->
	reassemble(disassemble(XML)).

reassemble(Parts) ->
	p05:reverse(reassemble(Parts, [])).
reassemble([{_, close} | Tail], Acc) ->
	{Tail, p05:reverse(Acc)};
reassemble([{H1, open}, {H2, open} | Tail], Acc) ->
	{Rest, Result} = reassemble([{H2, open} | Tail], []),
	reassemble(Rest, [{H1, [], Result} | Acc]);
reassemble([{H1, open}, {H2, value}, {_, close} | Tail], Acc) ->
	reassemble(Tail, [{H1, [], H2} | Acc]);
reassemble([], Acc) ->
	Acc.

disassemble(XML) ->
	p05:reverse(disassemble(XML, [])).
disassemble(<<_, _/binary>> = XML, Parts) ->
	{Rest, Part, Type} = determine(XML, <<>>, open),
	disassemble(Rest, [{Part, Type} | Parts]);
disassemble(<<>>, Parts) ->
	Parts.

determine(<<"</", Rest/binary>>, <<>>, _) ->
	determine(Rest, <<>>, close);
determine(<<"<", Rest/binary>>, <<>>, _) ->
	determine(Rest, <<>>, open);
determine(<<"<", _/binary>> = XML, Part, _) ->
	{XML, Part, value};
determine(<<">", Rest/binary>>, Part, Type) ->
	{Rest, Part, Type};
determine(<<Head, Rest/binary>>, Part, Type) ->
	determine(Rest, <<Part/binary, Head>>, Type);
determine(<<>>, Part, Type) ->
	{<<>>, Part, Type}.