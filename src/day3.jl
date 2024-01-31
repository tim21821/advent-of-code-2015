"""
Return the next position from `current` after following the `instruction`.
"""
function next(current::CartesianIndex{2}, instruction::Char)
    if instruction == '^'
        return current + CartesianIndex(0, -1)
    elseif instruction == 'v'
        return current + CartesianIndex(0, 1)
    elseif instruction == '>'
        return current + CartesianIndex(1, 0)
    elseif instruction == '<'
        return current + CartesianIndex(-1, 0)
    end
    return current
end

function part1()
    input = open("input/day3.txt") do f
        return readline(f)
    end

    current = CartesianIndex(0, 0)
    visited = Set([current])
    for c in input
        current = next(current, c)
        push!(visited, current)
    end
    return length(visited)
end

function part2()
    input = open("input/day3.txt") do f
        return readline(f)
    end

    santacurrent = CartesianIndex(0, 0)
    robocurrent = CartesianIndex(0, 0)
    visited = Set([santacurrent])
    for (i, c) in enumerate(input)
        if i % 2 == 1
            santacurrent = next(santacurrent, c)
            push!(visited, santacurrent)
        else
            robocurrent = next(robocurrent, c)
            push!(visited, robocurrent)
        end
    end
    return length(visited)
end

ans1 = part1()
println(ans1)
ans2 = part2()
println(ans2)
