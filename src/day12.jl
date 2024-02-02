import JSON

"""
Return the sum of all numbers in `j`.
"""
function unwrapnums(j::Dict{T,Any}) where {T<:Any}
    total = 0
    for (k, v) in j
        if typeof(k) == Int
            total += k
        elseif !(typeof(k) <: AbstractString)
            total += unwrapnums(k)
        end
        if typeof(v) == Int
            total += v
        elseif !(typeof(v) <: AbstractString)
            total += unwrapnums(v)
        end
    end
    return total
end

function unwrapnums(j::Vector{Any})
    total = 0
    for e in j
        if typeof(e) == Int
            total += e
        elseif !(typeof(e) <: AbstractString)
            total += unwrapnums(e)
        end
    end
    return total
end

"""
Return the sum of all numbers in `j` while ignoring all object containing the value
`"red"`.
"""
function unwrapignorered(j::Dict{T,Any}) where {T<:Any}
    if "red" in values(j)
        return 0
    end

    total = 0
    for (k, v) in j
        if typeof(k) == Int
            total += k
        elseif !(typeof(k) <: AbstractString)
            total += unwrapignorered(k)
        end
        if typeof(v) == Int
            total += v
        elseif !(typeof(v) <: AbstractString)
            total += unwrapignorered(v)
        end
    end
    return total
end

function unwrapignorered(j::Vector{Any})
    total = 0
    for e in j
        if typeof(e) == Int
            total += e
        elseif !(typeof(e) <: AbstractString)
            total += unwrapignorered(e)
        end
    end
    return total
end

function part1()
    input = open("input/day12.txt") do f
        return readline(f)
    end

    json = JSON.parse(input)
    return unwrapnums(json)
end

function part2()
    input = open("input/day12.txt") do f
        return readline(f)
    end

    json = JSON.parse(input)
    return unwrapignorered(json)
end
