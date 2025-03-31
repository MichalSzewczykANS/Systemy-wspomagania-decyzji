int: n = 4; 
set of int: V = 1..n; 
array[V] of var 1..n: kolor; 

int: m = 4; 
array[1..m, 1..2] of int: edges = array2d(1..m, 1..2, [1,2, 2,3, 3,4, 4,1]);

constraint forall(i in 1..m) (
    kolor[edges[i,1]] != kolor[edges[i,2]] 
);

solve minimize max(kolor); 

output ["Kolory: \n" ++ concat([show(kolor[i]) ++ " " | i in V])];