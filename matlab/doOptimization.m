% problem size
msizes = [100, 200, 300, 400, 500, 700, 1000, 1500, 2000];
matlab_times = zeros(length(msizes), 2);

filePath = strcat('../data/20160303_2000.csv');
varMatrix = csvread(filePath);

for i = 1:length(msizes)
    m = msizes(i);
    [var, tradingCost, expectedReturn, currentWeight] = paramaterReader(varMatrix, m);
    calc = CostCalculator(var, tradingCost, expectedReturn, currentWeight);
    [lb, ub, Aeq, beq] = createConstraints(m);
    A = [];
    b = [];
    nonlcon = [];
    guess = ones(m, 1) / m;

    % optimize with gradient
    options = optimoptions('fmincon','MaxFunEvals', 300000, 'GradObj','on', 'Algorithm', 'sqp');
    tic;
    [x_grad, fval_grad, exitflag_grad, output_grad] = fmincon(@calc.calculationWithGrad, guess, A, b, Aeq, beq, lb, ub, nonlcon, options);
    toc;
    matlab_times(i, 1) = toc;
end

