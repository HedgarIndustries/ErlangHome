-module(ets_api).
-export([create_table/0, insert_record/2, select_record/1, select_records_by_date/2, delete_record/1, delete_table/0]).

create_table() ->
	ets:new(planets, [set, named_table]).

insert_record(PlanetName, {Year, Month, Day, Hour, Minute, Second}) ->
	DateSeconds = calendar:datetime_to_gregorian_seconds({{Year, Month, Day}, {Hour, Minute, Second}}),
	ets:insert(planets, {PlanetName, DateSeconds}).

select_record(PlanetName) ->
	ets:lookup(planets, PlanetName).

select_records_by_date({SYear, SMonth, SDay, SHour, SMinute, SSecond}, {EYear, EMonth, EDay, EHour, EMinute, ESecond}) ->
	DateStartSeconds = calendar:datetime_to_gregorian_seconds({{SYear, SMonth, SDay}, {SHour, SMinute, SSecond}}),
	DateEndSeconds = calendar:datetime_to_gregorian_seconds({{EYear, EMonth, EDay}, {EHour, EMinute, ESecond}}),
	ets:select(planets, [{{'$1','$2'}, [{'=<', DateStartSeconds, '$2'}, {'=<', '$2', DateEndSeconds}], ['$$']}]).

delete_record(PlanetName) ->
	ets:delete(planets, PlanetName).

delete_table() ->
	ets:delete_table(planets).