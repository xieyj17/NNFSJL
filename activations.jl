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


mutable struct Softmax <: Activation
    layer::DenseLayer
    output::Array{Float64,2}
end

function softmax(layer::DenseLayer)
    r = Softmax(layer, layer.output)
    return r
end


function forward!(softmax_af::Softmax)
    input = softmax_af.layer.output
    exp_input = exp.(input)
    deno = sum(exp_input, dims = 2)
    new_output = input
    for i in 1:size(exp_input)[1]
        new_output[i,:] = exp_input[i,:] ./ deno[i]
    end
    softmax_af.output = new_output
end

#softmax_af = s1
