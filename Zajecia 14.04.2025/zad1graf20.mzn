int: nodesNumber = 20;
int: minColorsNumber = 3;
array[1..nodesNumber, 1..nodesNumber] of bool: edges = array2d(1..20, 1..20, [
  false, false, false, false, false, true, true, true, false, true, true, false, false, false, true, true, true, true, false, false, false, false, false, false, false, false, false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, true, false, false, false, false, false, true, false, false, false, true, false, true, false, false, false, false, false, false, false, false, true, false, true, true, true, true, true, true, false, false, false, true, false, false, false, false, false, false, false, false, true, true, false, true, false, false, false, false, false, true, false, false, true, false, false, false, false, false, true, false, false, false, false, false, false, true, false, false, false, false, true, false, true, false, true, false, false, true, false, false, false, false, false, false, true, false, false, true, false, false, false, false, true, true, true, false, false, false, false, false, true, false, false, false, false, false, true, true, true, false, false, false, false, true, false, true, true, false, false, true, false, false, true, true, true, false, false, false, false, true, true, true, true, false, false, false, true, false, false, false, false, false, true, true, true, false, false, false, true, false, false, true, true, false, false, true, false, false, false, false, true, true, false, false, true, false, false, true, false, false, false, false, false, true, false, true, true, false, false, false, true, true, false, false, true, false, false, false, true, false, false, false, false, false, false, true, false, false, true, false, true, true, true, true, false, true, true, false, false, false, false, true, false, false, true, true, false, true, false, false, false, false, false, false, true, false, false, false, false, true, false, false, true, false, false, true, false, false, false, true, false, false, false, false, true, false, false, true, false, false, false, false, true, false, false, true, false, false, true, true, false, false, true, false, false, false, true, false, true, false, false, false, true, false, false, false, false, false, false, true, false, true, false, true, false, false, false, true, false, false, true, false, true, false, true, false, true, false, false, false, true, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, true, false, false, true, false, false, false, false, false, false, false, true, false, false, false, false, false, true, true, false, false, false, false, true, true, false, false, true, false, false, false, false, false, false, false
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
