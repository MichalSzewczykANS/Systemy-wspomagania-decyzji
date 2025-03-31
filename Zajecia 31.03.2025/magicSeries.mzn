int: len = 5;
array[1..len] of var 0..len: magic;

constraint
  forall(i in 1..len) (
    magic[i] = sum(j in 1..len)(bool2int(magic[j] = i-1))
  );

solve satisfy;

output [show(magic) ++ "\n"];
