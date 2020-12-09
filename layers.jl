abstract type Layer end

mutable struct DenseLayer <: Layer
    weights::Array{Float64,2}
    biases::Array{Float64,2}
    output::Array{Float64,2}
end

function dense(n_inputs::Int64, n_neurons::Int64)
    weights = 0.01 * randn(n_inputs, n_neurons)
    biases = zeros(1, n_neurons)
    output = zeros(n_inputs, n_neurons)
    layer = DenseLayer(weights, biases, output)
    return layer
end

function forward!(layer::DenseLayer, inputs::Array{Float64,2})
    raw_output = inputs * layer.weights
    new_output = raw_output .+ layer.biases
    layer.output = new_output
end
