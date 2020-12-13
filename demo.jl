include("layers.jl")
include("activations.jl")
include("losses.jl")
include("miscellaneous.jl")

N = 100
D = 2
K = 3
X = zeros((N * K), D)
y = zeros(N * K)
for i = 0:(K-1)
    ix = (N*i+1):N*(i+1)
    r = LinRange(0.0, 1, N)
    t = LinRange(i * 4, (i + 1) * 4, N) + randn(N) * 0.2
    X[ix, :] = reshape(hcat(r .* sin.(t), r .* cos.(t)), N, D)
    y[ix] .= i
end

using Plots
scatter(X[:, 1], X[:, 2], marker_z = y, legend = false, color = :jet)

my = onehotencoder(y)

d1 = dense(2, 64)
forward!(d1, X)

r1 = relu(d1)
forward!(r1)

d2 = dense(64,3)
forward!(d2, r1.output)

s1 = softmax(d2)
forward!(s1)

c1 = categorical_cross_entropy(s1)
forward!(c1, my)

a1 = accuracy(s1)
forward!(a1, my)

backward!(a1, my)

o1 = optimizer_SDG(0.01)
