%% Problem A
clear
A = [1, 2, 3]; %one eqaulity constraint
b = 2;
cost_function = ones(3,1);

[optimal_x,optimal_cost,feasible_solutions] = find_BFS(A,b,cost_function);


%% Problem B
clear
A = [1, 0, 0, 1,-1, 0, -1, 0, 0, 0, 0, 0;...
     1, 0, 0,-1, 1, 0, 0, -1, 0, 0, 0, 0;...
     0, 1, 0, 1,-1, 1, 0, 0, -1, 0, 0, 0;...
     0, 1, 0,-1, 1,-1, 0, 0, 0, -1, 0, 0;...
     0, 0, 1, 2,-2, 0, 0, 0, 0, 0, -1, 0;...
     0, 0, 1,-2, 2, 0, 0, 0, 0, 0, 0, -1]; %six eqaulity constraints

b = [0,0,1,-1,3,-3]';

cost_function = [ones(3,1); zeros(9,1)];

[optimal_x,optimal_cost,feasible_solutions] = find_BFS(A,b,cost_function);
