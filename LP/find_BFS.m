function [optimal_sol,optimal_cost,feasible_solutions] = find_BFS(A,b, c)
%find_BFS Finds basic feasible soltions of standard form LP problem.
% The function receives constraints of the form Ax=b, 
% and a column vector of representing the cost function of the form c'*x.
%   - A - a matrix of equality constraints
%   - b - a column vector of constants for the equation
%   - c - a column vector of costs

%choose columns subsets
[subset_size, col_num] = size(A);
subsets = nchoosek(1:col_num,subset_size);
%find basic solutions
basic_solutions = [];

for ii = 1:size(subsets,1) %iterate over all subsets
    A_beta = A(:,subsets(ii,:));
    if rank(A_beta) == subset_size %% if A_beta is invertible
        tmp = zeros(col_num,1);
        tmp(subsets(ii,:)) = A_beta\b;
        basic_solutions = [basic_solutions tmp];
    end
end

if isempty(basic_solutions)
    error('no basic solutions found, check for errors in your constraints equation')
end

%feasability of basic solutions
%verify no typos in A, by verfying equality constraints
if max(max(abs(A*basic_solutions - repmat(b,1,size(basic_solutions,2))))) > 1e-5
    warning('equality constraints violated')
else
    disp('equality constraints satisfied')
end

%feasible solutions require only positive entries
feasible_solutions = [];
for ii = 1:size(basic_solutions,2) %iterate over all columns
    if min(basic_solutions(:,ii))>=0
        feasible_solutions = [feasible_solutions basic_solutions(:,ii)];
    end
end

if isempty(feasible_solutions)
    error('no feasible solutions found')
end

costs = c'*feasible_solutions;
[optimal_cost, optimal_idx] = min(costs);
optimal_sol = feasible_solutions(:,optimal_idx);
end

