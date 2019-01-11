% Place your solution here

day('Чук','Понедельник',0).
day('Чук','Вторник',0).
day('Чук','Среда',0).
day('Чук','Четверг',1).
day('Чук','Пятница',1).
day('Чук','Суббота',1).
day('Чук','Воскресенье',1).
day('Гек','Понедельник',1).
day('Гек','Вторник',0).
day('Гек','Среда',1).
day('Гек','Четверг',0).
day('Гек','Пятница',1).
day('Гек','Суббота',0).
day('Гек','Воскресенье',1).

yesterdayWas('Понедельник','Вторник').
yesterdayWas('Вторник','Среда').
yesterdayWas('Среда','Четверг').
yesterdayWas('Четверг','Пятница').
yesterdayWas('Пятница','Суббота').
yesterdayWas('Суббота','Воскресенье').
yesterdayWas('Воскресенье','Понедельник').

different('Гек', 'Чук').
different('Чук', 'Гек').
 
expression1(0, First) :- First \= 'Чук'.
expression1(1, First) :- First = 'Чук'.
 
expression2(0, Today) :- not(yesterdayWas('Воскресенье',Today)).
expression2(1, Today) :- yesterdayWas('Воскресенье',Today).
 
expression3(0, Today) :- not(yesterdayWas(Today,'Пятница')).
expression3(1, Today) :- yesterdayWas(Today,'Пятница').

expression4(SecondTrue, Second) :-
    day(Second, 'Среда', SecondTrue).
 
 
solve :-
    day(First, Today, FirstTrue),
    different(First, Second),
    day(Second, Today, SecondTrue),
    
    expression1(FirstTrue, First),
    expression2(FirstTrue, Today),
    expression3(SecondTrue, Today),
    expression4(SecondTrue, Second),
    
    write('First: '), write(First), nl,
    write('Second: '), write(Second), nl,
    write('Today: '), write(Today), nl,
    !.



