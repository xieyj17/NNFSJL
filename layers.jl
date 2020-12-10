abstract type Layer end

mutable struct DenseLayer <: Layer
    weights::Array{Float64,2}
    biases::Array{Float64,2}
    output::Array{Float64,2}
    input::Array{Float64,2}
    dweights::Array{Float64,2}
    dbiases::Array{Float64,2}
    dinputs::Array{Float64,2}
end

function dense(n_inputs::Int64, n_neurons::Int64)
    weights = 0.01 * randn(n_inputs, n_neurons)
    biases = zeros(1, n_neurons)
    output = zeros(n_inputs, n_neurons)
    input = zeros(1,1)
    dweights = zeros(size(weights))
    dbiases = zeros(size(biases))
    dinputs = zeros(1, n_inputs)
    layer = DenseLayer(weights, biases, output, input,
            dweights, dbiases, dinputs)
    return layer
end

function forward!(layer::DenseLayer, inputs::Array{Float64,2})
    raw_output = inputs * layer.weights
    new_output = raw_output .+ layer.biases
    layer.output = new_output
    layer.input = inputs
end

function backward!(layer::DenseLayer, dvalues::Array{Float64,2})
    new_dweights = layer.inputs' * dvalues
    new_dbiases = sum(dvalues, dims = 2)
    new_dinputs = dvalues * layer.weights'
    layer.dweights = new_dweights
    layer.dbiases = new_dbiases
    layer.dinputs = new_dinputs
end
