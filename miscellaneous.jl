function onehotencoder(y)
    n = size(y)[1]
    cates = unique(y)
    n_of_category = length(cates)
    cate_dict = Dict()
    for c = 1:n_of_category
        cate_dict[cates[c]] = c
    end

    res = zeros(n, n_of_category)

    for k = 1:n
        res[k, cate_dict[y[k]]] = 1
    end
    res = convert.(Int, res)
    return res
end
