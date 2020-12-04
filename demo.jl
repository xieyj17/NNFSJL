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

d1 = dense(2, 3)
forward!(d1, X)

r1 = relu(d1)
