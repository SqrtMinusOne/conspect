# III. Списки
**Список** - последовательность термов, перечисленных через запятую в квадратных скобках. Это основная структура данных Prolog.

Список делится на две части - **голову** и **хвост**. Для отделения головы и хвоста используется вертикальная черта. Хвост - всегда список.

Рассмотрим предикат `member`, который позволяет определить, относится ли элемент к списку. Обычно он уже встроен в Prolog.
```prolog
member(Elem, [Elem|_]).
member(Elem, [_|Tail]) :- member(Elem, Tail).
```
Если элемент относится к списку `Tail`, то он является элементом списка, к которому добавлена голова. В пустом списке голову и хвост выделить нельзя.

```prolog
| ?- member(a, [b, a, c]).
true ?
yes

| ?- member(a, [b, a, a]).
true ?
yes

| ?- member(a, [b, c, X]).
X = a
yes

| ?- member(X, [a, b, c]).
X = a ? a
X = b
X = c
yes
```

## Примеры работы со списком
### Соединение двух списков
```prolog
conc([], Q, Q).
conc([HP|TP], Q, [HP|TR]) :- conc(TP, Q, TR).
```

Пусть есть список:
```prolog
[jack,jim,jim,tim,jim,bob]
```
Надо найти списки слева и справа от `jim`.
```prolog
| ?- conc(L, [jim|R],[jack,jim,jim,tim,jim,bob]).

L = [jack]
R = [jim,tim,jim,bob] ? ;

L = [jack,jim]
R = [tim,jim,bob] ?

yes
```

### Получение n-го элемента списка.
```prolog
get(0, [H|_], H).
get(N, [_|T], L) :- N1 is N - 1, get(N1, T, L).
```
```prolog
| ?- get(0, [a,b,c],X).

X = a ?

yes
| ?- get(1, [a,b,c],X).

X = b ?

yes
| ?- get(2, [a,b,c],X).

X = c ?

yes

```

### Последний элемент списка
```prolog
fin([T], T).
fin([_|T], R) :- fin(T, R).
```
```prolog
| ?- fin([a, b, c, d, e], X).

X = e ?

yes
```



### Добавление элемента в список
```prolog
add(I,L,[I|L]).
```
```prolog
| ?- add(1, [], X).

X = [1]

yes
| ?- add(1, [1,2,3,4], X).

X = [1,1,2,3,4]

yes
```

### Удаление элемента из списка
```prolog
del(_, [], []) :- !.
del(I, [I|T], T) :- !.
del(I, [H|T], [H|R]) :- del(I, T, R).
```
```prolog
| ?- del(1, [1,2,3],X).

X = [2,3] ?

yes
| ?- del(2, [1,2,3],X).

X = [1,3] ?

yes
| ?- del(2, [1,2,3,2,1,2,3],X).

X = [1,3,2,1,2,3] ? a

X = [1,2,3,1,2,3]

X = [1,2,3,2,1,3]
```

### Сортировка списка
```prolog
del(_, [], []) :- !.
del(I, [I|T], T) :- !.
del(I, [H|T], [H|R]) :- del(I, T, R).

ordered([]) :- !.
ordered([_]) :- !.
ordered([H|[H1|T]]) :- H =< H1, ordered([H1|T]), !.

min([X], X) :- !.
min([H|T], X1) :- min(T, X1), X1 < H.
min([H|T], H) :- min(T, X1), X1 >= H.

sort_m(X, X) :- ordered(X), !.
sort_m(L, [M|T1]) :- min(L, M), del(M, L, L1), sort_m(L1, T1).
```
