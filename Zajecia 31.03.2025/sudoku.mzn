include "alldifferent.mzn";

int: S = 3;
int: N = S * S;

set of int: PuzzleRange = 1..N; 
array[PuzzleRange, PuzzleRange] of 0..N: board;

array[PuzzleRange, PuzzleRange] of var PuzzleRange: puzzle;


constraint
    forall(r, c in PuzzleRange) (
        board[r, c] > 0 -> puzzle[r, c] = board[r, c]
    );

constraint
    forall(r in PuzzleRange) (
        alldifferent([puzzle[r, c] | c in PuzzleRange]) 
    );

constraint
    forall(c in PuzzleRange) (
        alldifferent([puzzle[r, c] | r in PuzzleRange])
    );

constraint
    forall(sr, sc in 0..S-1) (
        alldifferent([puzzle[r, c] | r in (sr * S + 1)..(sr * S + S),
                                    c in (sc * S + 1)..(sc * S + S)])
    );

solve satisfy;

output [
    if j == 1 then "\n" else "" endif ++
    show(puzzle[i, j]) ++ " " ++
    (if j mod S == 0 /\ j != N then "| " else "" endif) ++
    (if j == N then "\n" else "" endif) ++
    (if i mod S == 0 /\ j == N /\ i != N then "------+-------+------\n" else "" endif)
    | i, j in PuzzleRange
];
