using Combinatorics

"""
Return the quantum entanglement of the presents with the given `weights`.
"""
function quantumentanglement(weights::Vector{Int})
    ans = 1
    for weight in weights
        ans *= weight
    end
    return ans
end

function part1()
    lines = open("input/day24.txt") do f
        return readlines(f)
    end

    weights = parse.(Int, lines)
    weightpergroup = sum(weights) ÷ 3
    validgroups = Vector{Vector{Int}}()
    i = 1
    while isempty(validgroups)
        for c in combinations(weights, i)
            if sum(c) == weightpergroup
                push!(validgroups, c)
            end
        end
        i += 1
    end
    return minimum(quantumentanglement, validgroups)
end

function part2()
    lines = open("input/day24.txt") do f
        return readlines(f)
    end

    weights = parse.(Int, lines)
    weightpergroup = sum(weights) ÷ 4
    validgroups = Vector{Vector{Int}}()
    i = 1
    while isempty(validgroups)
        for c in combinations(weights, i)
            if sum(c) == weightpergroup
                push!(validgroups, c)
            end
        end
        i += 1
    end
    return minimum(quantumentanglement, validgroups)
end
