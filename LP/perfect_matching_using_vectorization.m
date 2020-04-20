%% Q5 - section b
cardinality = 100;
num_of_interations = 100;
max_match_cost = 50;
sigificant_digits = 5;

%equality constraints
A = [kron(ones(1,cardinality),eye(cardinality));kron(eye(cardinality),...
    ones(1,cardinality))];
b = ones(2*cardinality,1);

%positivity bound
lb = zeros(1,cardinality^2);

options = optimoptions('linprog','Display','off');

relaxed_solutions_rate = zeros(1,cardinality);
integer_solutions_rate = zeros(1,cardinality);

for k=2:cardinality % go over k's
    relaxed_solutions = 0;
    integer_solutions = 0;
    for iteration = 1:num_of_interations % iterate 100 times
        W = zeros(cardinality); % create empty costs
        potential_matches = randi(cardinality,cardinality,k); % choose k edges for each male randomly
        matches_costs = randi(max_match_cost,cardinality,k);    % choose edges costs
        for idx = 1:cardinality % poplate W
            W(idx,potential_matches(idx,:)) = matches_costs(idx,:);
        end
        
        W_vec = -W(:);
        ub = ones(1,cardinality^2);
        ub(W_vec==0) = 0; % disallow matches for non-existing (zero values) edges
        x_vec = linprog(W_vec',[],[],A,b,lb,ub,options);  
        if ~isempty(x_vec)
            relaxed_solutions = relaxed_solutions + 1;
            if round(x_vec,sigificant_digits)==round(x_vec) % if solution is integer up to sigificant_digits
                integer_solutions = integer_solutions +1;
            end
        end
        
    end
    relaxed_solutions_rate(k) = relaxed_solutions/num_of_interations;
    integer_solutions_rate(k) = integer_solutions/num_of_interations;
end

plot(relaxed_solutions_rate)
hold on
plot(integer_solutions_rate)
close all
plot(relaxed_solutions_rate,'*')
hold on
plot(integer_solutions_rate)
legend('relaxed', 'integer')
xlabel('k - number of possible matches of each male')
ylabel('Perfect matching success rate')
saveas(gcf,'success_rate.eps','epsc')