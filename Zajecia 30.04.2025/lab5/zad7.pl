silnia(0, 1).
silnia(N, F) :-
    N > 0,
    N1 is N - 1,
    silnia(N1, F1),
    F is N * F1.

fibo(0, 0).
fibo(1, 1).
fibo(N, F) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibo(N1, F1),
    fibo(N2, F2),
    F is F1 + F2.
