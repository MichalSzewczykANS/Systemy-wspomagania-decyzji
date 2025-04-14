int: nodesNumber = 10;
int: minColorsNumber = 3;
array[1..nodesNumber, 1..nodesNumber] of bool: edges = array2d(1..10, 1..10, [
  false, true, false, false, true, false, false, false, false, false, true, false, true, false, false, false, true, true, true, false, false, true, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, true, false, false, false, true, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, true, false, true, false, false, false, false, false, false, false, false, false, true, false, false, true, false, false, false, false, true, false, false, false, false, false, false, true, false, true, false
]);

array[1..nodesNumber] of var 1..nodesNumber: nodes;
var 1..nodesNumber: colorsNumber;

constraint colorsNumber = max(nodes);

constraint
  forall(i, j in 1..nodesNumber where edges[i,j]) (
    nodes[i] != nodes[j]
  );

constraint
  forall(i in 1..minColorsNumber)(
    nodes[i] = i
  );

solve minimize colorsNumber;
