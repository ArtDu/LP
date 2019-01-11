pol(A, Ans) :- pol(A, Ans, _).

pol([], Ans, _).

pol(['+', A| T], (X+Y), Ret1):-
  pol([A|T], X, Ret),
  pol(Ret, Y, Ret1), !.

pol(['*', A| T], (X*Y), Ret1):-
  pol([A|T], X, Ret),
  pol(Ret, Y, Ret1), !.

pol([A|T], A, T).

/*2+(3*5)


 вызов in(T)
in(A+B):- !
in(A*B):- !
in(X)*/




%% same([1,2,3,4],[3,4,5,6],X), X=2.

same(List1,List2,X):-
	intersection(List1,List2,XList),length(XList,X).