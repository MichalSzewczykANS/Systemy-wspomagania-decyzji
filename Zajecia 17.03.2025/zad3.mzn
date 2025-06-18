include "dane.dzn";

int: n;  
array[1..n] of int: prices;  
int: target; 
array[1..n] of var 0..target div min(prices): counts;  

constraint sum(i in 1..n)(prices[i] * counts[i]) = target; 

solve satisfy;

output [ "Posiłek " ++ show(i) ++ ": " ++ show(counts[i]) ++ "\n" | i in 1..n ];