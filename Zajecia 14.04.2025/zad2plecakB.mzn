int: items_n = 8;
int: knapsacks_n=4;
int: capacity=15;

array[1..items_n] of int: values=[10, 5, 15, 7, 6, 18, 3, 12];
array[1..items_n] of int: weights = [4, 2, 6, 5, 3, 7, 2, 5];

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
