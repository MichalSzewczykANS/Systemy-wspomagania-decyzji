delta(A, B, C, D) :-
    D is B * B - 4 * A * C.

kwadrat(A, B, C, Pierwiastki) :-
    delta(A, B, C, D),
    (
        D < 0 ->
            Pierwiastki = brak_rozwiazan
        ;
        D =:= 0 ->
            X is -B / (2 * A),
            Pierwiastki = jeden(X)
        ;
        D > 0 ->
            PierwiastekD is sqrt(D),
            X1 is (-B + PierwiastekD) / (2 * A),
            X2 is (-B - PierwiastekD) / (2 * A),
            Pierwiastki = dwa(X1, X2)
    ).
