relative(X,Y,Z):-relative(X,Y,Z,'deep').
%очевидные отношения
relative(father, X, Y, _):- parents(X,Y,_),!.
relative(mother, X, Y, _):- parents(X,_,Y),!.
relative(daugther, X, Y, _):-parents(Y,_,X), parents(_,_,Y),!.
relative(daugther, X, Y, _):-parents(Y,X,_), parents(_,_,Y),!.
relative(son, X, Y, _):-parents(Y,_,X), parents(_,Y,_),!.
relative(son, X, Y, _):-parents(Y,X,_), parents(_,Y,_),!.
relative(sister, X, Y, _):- parents(X,Father,Mother),parents(Y,Father,Mother),parents(_,_,Y),!.
relative(brother, X, Y, _):-parents(X,Father,Mother),parents(Y,Father,Mother),parents(_,Y,_),!.
relative(wife, X, Y,_):- parents(_,X,Y),!.
relative(husband, X, Y,_):- parents(_,Y,X),!.
%более глубокая взаимосвязь
relative(Surf-Deep, X, Y, N):-
	N = 'deep',
	relative(Deep, X, Intermediate, 'deep'),
	not(X = Intermediate),
	relative(Surf, Intermediate, Y, 'surface'),
	not(Y = Intermediate),
	not(X = Y).