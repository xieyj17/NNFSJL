abstract type Activation end

mutable struct ReLU <: Activation
    layer::DenseLayer
    input::Array{Float64,2}
    output::Array{Float64,2}
    dinputs::Array{Float64,2}
end

function relu(layer::DenseLayer)
    r = ReLU(layer, layer.input, layer.output,
        zeros(size(layer.input)))
    return r
end


function forward!(relu_af::ReLU)
    input = relu_af.layer.output
    new_output = max.(0, input)
    relu_af.output = new_output
end

function backward!(relu::ReLU, dvalues::Array{Float64,2})
    new_dinputs = copy(dvalues)
    for i in length(relu.input
        if i <= 0
            new_dinputs[i]
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
    for i = 1:size(exp_input)[1]
        new_output[i, :] = exp_input[i, :] ./ deno[i]
    end
    softmax_af.output = new_output
end
