abstract type Optimizer end

mutable struct StochasticGradientDescent <: Optimizer
    learning_rate::Float64
end

function optimizer_SDG(learning_rate::Float64=1.0)
    opt = StochasticGradientDescent(learning_rate)
    return opt
end

function update_parameters!(sdg::StochasticGradientDescent, layer::DenseLayer)

end
