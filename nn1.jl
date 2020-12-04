abstract type Layer end

struct Dense_Layer <: Layer
    weights::Array{Float64,1}
    biases::Array{Float64,1}
end

function Initialize_Layer(n_inputs::UInt64, n_neurons::UInt64)
    weights = 0.01 * randn(n_inputs, n_neurons)
    biases = zeros(1, n_neurons)
    layer = Dense_Layer(weights, biases)
    return layer
end
