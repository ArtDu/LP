fact(N,Res):-fact(N, 1 ,Res).

fact(0,Res,Res):-!.

fact(N, Cur, Res):-
	N1 is N - 1,
	Acc is N * Cur,
	fact(N1, Acc, Res).



pow(X,N,T):-pow(X,N,1,T).

pow(_,0,Res,Res):-!.

pow(X,N,Acc,T):-
	Acc1 is Acc * X,
	N1 is N-1,
	pow(X,N1,Acc1,T).


fib(N,R):-fib(N,2,1,1,R).

fib(N,N,Res,_,Res):-!.

fib(N,NCur,Fst,Snd,R):-
	Fst1 is Fst + Snd,
	Snd1 is Fst,
	NCur1 is NCur + 1,
	fib(N,NCur1,Fst1,Snd1,R).
	


getlast(List,Last):-
	append(_,[Last],List).


dellast(List,Res):-
	append(Res,[_],List).

