inputs = [1, 2, 3, 2.5]

weights = [[0.2, 0.8, -0.5, 1],
            [0.5, -0.91, 0.26, -0.5],
            [-0.26, -0.27, 0.17, 0.87]]

bias = [2,3,1]

output = []
for (w,b) in zip(weights, bias)
    append!(output, inputs' * w + b)
end

output = [inputs' * weights1 + bias1, inputs' * weights2 + bias2,
    inputs' * weights3 + bias3]


N = 100
D = 2
K = 3
X = zeros((N*K), D)
y = zeros(N*K)
for i in 0:(K-1)
    ix = (N*i+1) : N*(i+1)
    r = LinRange(0.0,1,N)
    t = LinRange(i*4, (i+1)*4, N) + randn(N)*0.2
    X[ix,:] = reshape(hcat(r .* sin.(t), r .* cos.(t)), N, D)
    y[ix] .= i
end

using Plots
scatter(X[:,1], X[:,2], marker_z = y, legend=false, color = :jet)
