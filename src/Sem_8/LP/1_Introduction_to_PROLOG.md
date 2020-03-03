# I. Введение в PROLOG

PROLOG - Programming in Logic. Логическое программирование - один из видов программирования.

Большинство задач ИИ - переборные; PROLOG не ориентирован на решение переборных задач, поэтому он не получил широкого распространения.

PROLOG позволяет задать корректное математическое описание задачи; если это получается - задача решается автоматически. Это отличается от **императивных** парадигм программирования, где нужно задать последовательность решения задачи.

Программист задает законы предметной области и **вопрос**. Ответ на вопрос может быть только **да** или **нет**, значения переменных и т.п. - побочные результаты.

## Примеры
Запишем факт, что Том является родителем Боба:
```prolog
parent(tom,bob).
```

Зададим вопрос:
```prolog
?-parent(tom,bob).
```
Получим `yes`.

Расширим родственные связи:
```prolog
parent(tom,bob).
parent(ann,bob).
parent(tom,liza).
parent(bob,mary).
parent(bob,luk).
parent(luk,kate).
```

**Вопрос:**
```
?-parent(tom,liza).
```
Сначала производится сравнение вопроса с первым фактом. Ответ `No`, переход к следующему факту. На третьем факте ответ - `yes`.

**Вопрос:**
```
?-parent(X,liza).
```
`X` - переменная. Производится сравнение:
1. `X=tom, liza=bob` > `No`
2. `X=ann, liza=bob` > `No`
3. `X=tom, liza=liza` > `yes`

PROLOG даст ответ:
```prolog
X=tom
yes
```

**Вопрос**:`? - parent(tom,X)`
Будет ответ:
```
X=bob
```
Если здесь нажать `;`, будет:
```prolog
X=liza
yes
```
Если нажать `Enter`, будет выведен только первый ответ.

**Вопрос** *кто является прародителем `luk`?*:
```prolog
?-parent(X,Y),parent(Y,luk).
```
Здесь запятая играет роль **И**.
```prolog
X=tom
Y=bob;
X=ann
Y=bob
yes
```
PROLOG выводит все возможные наборы переменных на каждой строке.

**Вопрос:** *кто является правнуками `tom`?*
```prolog
?-parent(tom,X),parent(X,Y),parent(Y,Z).
```
Ответ:
```
X=bob
Y=luk
Z=kate
yes
```

**Вопрос:** *Верно ли, что `bob` и `liza` имеют общего родителя*?
```prolog
?-parent(X,bob),parent(X,liza).
```
Ответ:
```prolog
X=tom
yes
```
Поскольку результат `X=tom`, можно использовать *анонимную переменную*:
```prolog
?-parent(_,bob),parent(_,liza).
```

### Расширение программы

Определим пол всех людей. Это можно сделать так:
```prolog
female(kate).
make(tom).
```
или так:
```prolog
gender(kate, feminine).
gender(tom, masculine).
```

Расширим программу понятием "потомок":
```prolog
offspring(bob,tom).
```
Это можно определить в виде **правила**:
```prolog
offspring(X,Y):-parent(Y,X).
```
Это все конструкции в PROLOG:
* Факты
* Правила
* Вопросы

Факт описывает условие которое всегда верно. Правило читается справа налево.

Правило вывода: $$ \frac{A, A\to B}{B} $$

Программа "Мама":
```prolog
parent(tom,bob).
parent(ann,bob).
parent(tom,liza).
parent(bob,mary).
parent(bob,luk).
parent(luk,kate).
male(tom).
male(bob).
female(ann).
female(liza).
female(mary).
male(luk).
female(kate).
mother(X,Y):-parent(X,Y),female(X).
```