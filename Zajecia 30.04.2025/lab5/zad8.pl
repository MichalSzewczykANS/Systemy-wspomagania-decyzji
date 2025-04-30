kolor(czerwony).
kolor(zielony).
kolor(niebieski).

koloruj(P1, P2, P3, P4, P5) :-
    kolor(P1),
    kolor(P2),
    kolor(P3),
    kolor(P4),
    kolor(P5),

    P1 \= P2,
    P1 \= P3,

    P2 \= P3,
    P2 \= P4,

    P3 \= P4,
    P3 \= P5,

    P4 \= P5.
