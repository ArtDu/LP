%определение оператора, используемого в словаре
op(200, xfy, ':').


question(A):-
  gen(File),
  fid(A, File).

fid(A, File):-
  member(A, File).

%Предикат имени
name(X):-
  parents(X,_,_).
name(X):-
  parents(_,X,_).
name(X):-
  parents(_,_,X).

%How many brothers does Lisa have?
a_phrase([A,B,C,D,E,F|_]):-
    question(A:B:type('count')),
    many(C,Rel),
    question(D:type('approve')),
    name(E),
    question(F:type('having')),
    setof(N,relative(Rel,E,N),L),
    length(L,N1),
    write("There are "), write(N1),
    write(" "),
    write(C),nl,
    write(L), nl, !.

%Does Mary has brother Paulo?
a_phrase([A,B,C,D,E|_]):-
  question(A:type('approve')),
  name(B),
  question(C:type('having')),
  many(D,Rel),
  name(E),
  relative(Rel,B,E),
  write("Yes, it is"), nl, !.

a_phrase([A,B,C,D,E|_]):-
  question(A:type('approve')),
  name(B),
  question(C:type('having')),
  many(D,_),
  name(E),
  write("No, this is wrong"), nl,!.

a_phrase(_):- write("Can not understand question. Please, be more specific"), nl.


%СЛОВАРИ
gen(F):-
  F=[
    'Does':type('approve'),
    'does':type('approve'),
    'Is':type('approve'),
    'is':type('approve'),

    'How':'many':type('count'),
    'how':'many':type('count'),

    'How':'related':type('relative'),
    'how':'related':type('relative'),

    'It':type('refer'),
    'it':type('refer'),
    'Him':type('refer'),
    'him':type('refer'),
    'Her':type('refer'),
    'her':type('refer'),

    'have':type('having'),
    'Have':type('having'),
    'has':type('having'),
    'Has':type('having')
    ].
many(S, S1):-
  gen_many(Many_list),
  member(S:S1, Many_list).

%множественное число
gen_many(F):-
  F=[
  fathers:father,
  mothers:mother,
  daugthers:daugther,
  sons:son,
  sisters:sister,
  brothers:brother,
  wives:wife,
  husbands:husband,
  father:father,
  mother:mother,
  daugther:daugther,
  son:son,
  sister:sister,
  brother:brother,
  wife:wife,
  husband:husband
  ].


  
