"""
Return the number of combinations of `containers` to fit the `volume`.
"""
function combinations(containers::Vector{Int}, volume::Int)
    if length(containers) == 1
        return containers[1] == volume || volume == 0 ? 1 : 0
    end
    return combinations(containers[2:end], volume - containers[1]) +
           combinations(containers[2:end], volume)
end

"""
Return a `Dict` of used containers => number of possible combinations of `containers` to
fit the `volume` with `numused` containers already used.
"""
function combinations(containers::Vector{Int}, volume::Int, numused::Int)
    if length(containers) == 1
        if containers[1] == volume
            return Dict(numused + 1 => 1)
        elseif volume == 0
            return Dict(numused => 1)
        else
            return Dict{Int,Int}()
        end
    end

    return mergewith(
        +,
        combinations(containers[2:end], volume - containers[1], numused + 1),
        combinations(containers[2:end], volume, numused),
    )
end

function part1()
    lines = open("input/day17.txt") do f
        return readlines(f)
    end

    containers = parse.(Int, lines)
    return combinations(containers, 150)
end

function part2()
    lines = open("input/day17.txt") do f
        return readlines(f)
    end

    containers = parse.(Int, lines)
    possiblecombinations = combinations(containers, 150, 0)
    return possiblecombinations[minimum(keys(possiblecombinations))]
end
