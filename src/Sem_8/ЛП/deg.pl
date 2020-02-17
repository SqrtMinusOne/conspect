pow(_, 0, 1).
pow(N, P, R) :- N > 0, P1 is P - 1, pow(N, P1, V), R is V * N.
