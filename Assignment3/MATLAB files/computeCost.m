function cost = computeCost(LB,g,f,lambda)

cost = sum((f-g).*(f-g)) + lambda*g'*LB*g;
