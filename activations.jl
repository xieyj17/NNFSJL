abstract type Activation end

mutable struct ReLU <: Activation
    layer::DenseLayer
    output::Array{Float64,2}
end

function relu(layer::DenseLayer)
    r = ReLU(layer, layer.output)
    return r
end


function forward!(relu_af::ReLU)
    input = relu_af.layer.output
    new_output = max.(0, input)
    relu_af.output = new_output
end
