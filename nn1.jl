abstract type Layer end

struct Dense_Layer <: Layer
    weights::Array{Float64,2}
    biases::Array{Float64,2}
end

function Initialize_Layer(n_inputs::Int64, n_neurons::Int64)
    weights = 0.01 * randn(n_inputs, n_neurons)
    biases = zeros(1, n_neurons)
    layer = Dense_Layer(weights, biases)
    return layer
end

k = Initialize_Layer(10,3)

function Dense_Forward(layer::Dense_Layer, inputs::Array{Float64,2})
    output = inputs' * layer.weights
    output += bs
    return output
end

Dense_Forward(k, inputs)
