function wass = wasserstein_distance_nd(u,v,ordem)


[m, d] = size(u);
[n, ~] = size(v);

A_upper_cells = cell(1, m);

for i = 1:m
    A_upper_cells{i} = ones(1, n);
end
A_upper_part = blkdiag(A_upper_cells{:});

eye_n = speye(n);
A_lower_cells = cell(1, m);
for i = 1:m
    A_lower_cells{i} = eye_n;
end
A_lower_part = horzcat(A_lower_cells{:});

A = sparse([A_upper_part; A_lower_part]);

D = zeros(m, n);
for i = 1:m
    for j = 1:n
        % Distância euclidiana entre u(i,:) e v(j,:)
        D(i,j) = norm(u(i,:) - v(j,:), ordem);
    end
end

cost = D(:);

p_u = ones(m, 1) / m;
p_v = ones(n, 1) / n;
b = [p_u; p_v];



[~, fval] = linprog(-b, A', cost, [], [], [], [], optimoptions('linprog', 'Display', 'none'));

wass = - fval/d;
end