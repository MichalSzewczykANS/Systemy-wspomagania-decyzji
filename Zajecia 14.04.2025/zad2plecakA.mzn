int: items_n = 6;
int: knapsacks_n=2;
int: capacity=10;

array[1..items_n] of int: values=[4, 2, 7, 1, 6, 3];
array[1..items_n] of int: weights = [2, 1, 4, 1, 3, 2];

array[1..knapsacks_n, 1..items_n] of var 0..1: taken;

constraint
  forall(j in 1..items_n)(
    sum(i in 1..knapsacks_n)(taken[i,j]) <= 1
  );

constraint
  forall(i in 1..knapsacks_n)(
    sum(j in 1..items_n)(weights[j] * taken[i,j]) <= capacity
  );

var int: total_value = sum(i in 1..knapsacks_n, j in 1..items_n)(values[j] * taken[i,j]);
solve maximize total_value;
