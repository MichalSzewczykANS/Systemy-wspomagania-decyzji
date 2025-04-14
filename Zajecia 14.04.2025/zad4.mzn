include "globals.mzn";

int: N;

array[1..N] of var 1..N: rows;
array[1..N] of var 1..N: cols;

constraint alldifferent(rows);

constraint alldifferent([rows[i] + i | i in 1..N]);

constraint alldifferent([rows[i] - i | i in 1..N]);

constraint inverse(rows, cols);

solve satisfy;

output ["rows = ", show(rows), "\ncols = ", show(cols)];
