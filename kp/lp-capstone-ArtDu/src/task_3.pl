%% (Теща, мужчина)
motherInLaw(Z,X) :- parents(_,X,Y), parents(Y,_,Z), !.