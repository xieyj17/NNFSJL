
abstract type Loss end

mutable struct CategoricalCrossEntropy <: Loss
    input::Array{Float64,2}
    output::Float64
    dinputs::::Array{Float64,2}
end

function categorical_cross_entropy(sm_layer::Softmax)
    cce = CategoricalCrossEntropy(sm_layer.output, 0.0,
    zeros(size(sm_layer.output)))
end

function forward!(cce::CategoricalCrossEntropy, y::AbstractArray)
    sm_res = cce.input
    number_of_sample = size(sm_res)[1]
    clamp!(sm_res, 1e-7, 1 - 1e-7)

    correct_prob = zeros(number_of_sample)

    if length(size(y)) == 1
        y = convert.(Int, y)
        if minimum(y) == 0
            y = y .+ 1
        end
        for p = 1:number_of_sample
            correct_prob[p] = sm_res[p, y[p]]
        end
    elseif length(size(y)) == 2
        y = convert.(Int, y)
        for p = 1:number_of_sample
            correct_prob[p] = sum(sm_res[p, :] .* y[p, :])
        end
    end

    neg_log = -1 * log.(correct_prob)
    avg_loss = sum(neg_log) / number_of_sample

    cce.output = avg_loss
end

function backward!(cce::CategoricalCrossEntropy,
    dvalues::dvalues::Array{Float64,2}, y::AbstractArray)
    n_of_samples = size(dvalues)[1]
    n_of_labels = size(dvalues)[2]
    if length(size(y)) == 1
        y = onehotencoder(y)
    end
    cce.dinputs = -y ./ dvalues
    cce.dinputs = cce.dinputs / n_of_samples
end


mutable struct Accuracy <: Loss
    input::Array{Float64,2}
    accuracy::Float64
end

function accuracy(sm_layer::Softmax)
    acc = Accuracy(sm_layer.output, 0.0)
end


function forward!(acc::Accuracy, y::AbstractArray)
    sm_res = acc.input
    number_of_sample = size(sm_res)[1]

    predictions = argmax(sm_res, dims = 2)
    pred = [predictions[i][2] for i = 1:number_of_sample]

    if length(size(y)) == 1
        y = convert.(Int, y)
        if minimum(y) == 0
            y = y .+ 1
        end
        res = sum(y .== pred) / number_of_sample
    elseif length(size(y)) == 2
        y = convert.(Int, y)
        y = argmax(y, dims = 2)
        y = [y[i][2] for i = 1:number_of_sample]
        res = sum(y .== pred) / number_of_sample
    end

    acc.accuracy = res
end
