%% part 2
%Данные: 3 (three.pl)
%Вариант: 3
%    Для каждого студента, найти средний балл, и сдал ли он экзамены или нет
%    Для каждого предмета, найти количество не сдавших студентов
%    Для каждой группы, найти студента (студентов) с максимальным средним баллом

:- ['three.pl'].

%2.1 Для каждого студента, найти средний балл, и сдал ли он экзамены или нет
%(Студент, Средняя оценка)
averageMark(Stud,Mark):-
	student(_,Stud,Z),
	sum(Z, Sum),
	length(Z,Len),
	Mark is Sum / Len.
	
	
%Cумма всех элементов в списке
%(Список, Сумма)
sum([grade(_, H)|T],N):-
	sum(T,N1),
	N is N1+H.
sum([],0).

%Сдал ли студент экзамены
%Если хотя бы одна двойка, то false
%(Студент)
passExams(Stud):-
	student(_,Stud,Marks),
	not(member(grade(_,2),Marks)).

%2.2 Для каждого предмета, найти количество не сдавших студентов
%(Предмет, количество)
countOfFailed(Subj,N):-
	subject(Ss,Subj),
	findall(A,(student(_,_,A),gradeInList(A,Ss)),AllMarks),
	length(AllMarks,N).

gradeInList([grade(Subj,2)|_],Subj).
gradeInList([_|Tail],Subj):-
	gradeInList(Tail,Subj).
	
%2.3 Для каждой группы, найти студента (студентов) с максимальным средним баллом
%(Группа, Список учеников с максимальным средним баллом)
bestStudent(Group,N):-
  %собираем список со всеми средними оценками
  findall(Mark, (student(Group,Stud,_), averageMark(Stud,Mark)),Marks),
  %находим мвксимальную из них
  max(Marks,Max),
  %составляем список из всех студентов имеющих такую оценку
  findall(A,(student(Group,A,_), averageMark(A,M), M==Max), N),!.

%Нахождение максимального из положительного числового списка
%(Список, максимум)
max([],0).
max([H|T],N):-
  max(T,B),
  H =< B,
  N is B.
max([H|T],N):-
  max(T,B),
  H >= B,
  N is H.