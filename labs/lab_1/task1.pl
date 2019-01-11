% Дубинин Артем. 6 по списку, 206Б
% part 1.0
% Реализация стандартных предикатов обработки списков
    
    % Принадлежность элемента списку
    % (элемент, список)
    listMember(X, [X | _]).
    listMember(X, [_ | T]):-listMember(X, T).
    
    % Длина списка
    % (список, длина)
    listLength([], 0).
    listLength([_ | L], N):-listLength(L, M), N is M + 1.
    
    % Конкатенация списков
    % (список1, список2, список1+2)
    listAppend([], L, L).
    listAppend([X | L1], L2, [X | L3]):-listAppend(L1, L2, L3).
    
    % Удаление элемента из списка
    % (элемент, список, список без элемента)
    listDelete(X, [X | T], T).
    listDelete(X, [Y | T], [Y | Z]):-listDelete(X, T, Z).

    % Перестановки элементов в списке
    % (список, перестановка)
    listPermutation([], []).
    listPermutation(L, [X | T]):-listDelete(X, L, Y), listPermutation(Y, T).
    
    % Подсписки списка
    % (подсписок, список)
	listSubl(S, L):-listAppend(_, L1, L), listAppend(S, _, L1).

% part 1.1
% Предикат, который усекает список до указанной длины
% Первый параметр - исходный список, второй - длина, третий - результат.
	% Версия с использованием стандартных предикатов
	truncation(List,Length,Result):-append(Result, _, List), length(Result, Length), !.
	% Версия без использования стандартных предикатов
	truncation2(_,0,[]).
	truncation2([ListHead|ListTail],Length,[ListHead|ResultTail]):-
		Length1 is Length - 1,
		truncation2(ListTail, Length1, ResultTail),!.

% Part 1.2
% Предикат, который вычисляет позицию минимального элемента в числовом списке
% Первый параметр - исходный список, второй - позиция.
	% Версия с использованием стандартных предикатов
	minElemPos(List,Pos):-min_list(List,MinElem), nth0(Pos,List,MinElem), !.
	% Версия без использования стандартных предикатов
    minElemPos2(List,Pos):-
        minForList(List,Min),
        minPosForList(List,0,Pos,Min),!.

    minPosForList([Min|_],Pos,Pos,Min).
    minPosForList([_|Ls],Pos1,Pos,Min):-
        Pos2 is Pos1+1,
        minPosForList(Ls,Pos2,Pos,Min).

    minForTwo(X,Y,X):- X=<Y, !.
    minForTwo(X,Y,Y):- X>Y.

    minForList([L|Ls], Min) :-
        minForList(Ls, L, Min).

    minForList([], Min, Min).
    minForList([Head|Tail], Min0, Min):-
        Min1 is min(Head,Min0),
        minForList(Tail, Min1, Min).


% Part 1.3
% Предикат, который отсекает список до минимального элемента.
% Первый параметр - исходный список, второй - результат.

    truncationSpec(List,Result):-
        minElemPos(List,Pos),truncation(List,Pos,Result).   