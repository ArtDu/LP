true(river_volga).
true(pupil_vasya).
true(true).


calculate(List,Res):-
	analyzer(List,[Res]).

analyzer(['(',true,')'|T],Res):-
	analyzer([true|T],Res).
analyzer(['(',false,')'|T],[false|T]):-
	analyzer([false|T],Res).

analyzer([A,'&',B | T], Res):-
	true(A),
	true(B),
	valid(A),
	valid(B),
	analyzer([true|T],Res),
	!.

analyzer([A,'&',B | T], Res):-
	valid(A),
	valid(B),
	analyzer([false|T],Res).

analyzer([A,'=>',B | T], Res):-
	(not(true(A));true(B)),
	valid(A),
	valid(B),
	analyzer([true|T],Res),
	!.

analyzer([A,'=>',B | T], Res):-
	valid(A),
	valid(B),
	analyzer([false|T],Res).

analyzer(['~',B | T], Res):-
	true(B),
	valid(B),
	analyzer([false|T],Res),
	!.

analyzer(['~',B | T], Res):-
	valid(B),
	analyzer([true|T],Res).

analyzer([A,'&',B | T], Res):-
	valid(A),
	valid(B),
	analyzer([false|T],Res).

analyzer([A,'V',B | T], Res):-
	(true(A);true(B)),
	valid(A),
	valid(B),
	analyzer([true|T],Res),
	!.

analyzer([A,'V',B | T], Res):-
	valid(A),
	valid(B),
	analyzer([false|T],Res).

analyzer([A|[B|T]],Res):-
	% so the tail has to be non empty
	analyzer([B|T],Y),
	% analyzer can not complete args
	[B|T] \= Y,
	analyzer([A|Y],Res),!.

analyzer(X,X).

valid(X):-
	X \= '(',
	X \= ')',
	X \= '&',
	X \= '=>',
	X \= '~',
	X \= 'V'.


%% analyzer([true,'&','(','river_volga','&',true,')'],RES).