int: N;
array [1..N] of var 1..N: H; 

include "alldifferent.mzn";

constraint alldifferent(H);                     
constraint alldifferent([ H[i] + i | i in 1..N]); 
constraint alldifferent([ H[i] - i | i in 1..N]);

solve :: int_search(H, first_fail, indomain_min)
      satisfy;
output [ if fix(H[j]) == i then "H" else "." endif ++
         if j == N then "\n" else "" endif | i,j in 1..N];