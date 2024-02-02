"""
Return the look-and-say sequence generated from `str`.
"""
function lookandsay(str::AbstractString)
    out = ""
    counter = 0
    current = str[1]
    for c in str
        if c == current
            counter += 1
        else
            out *= string(counter) * current
            current = c
            counter = 1
        end
    end
    out *= string(counter) * current
    return out
end

function part1()
    input = open("input/day10.txt") do f
        return readline(f)
    end

    for _ in 1:40
        input = lookandsay(input)
    end
    return length(input)
end

function part2()
    input = open("input/day10.txt") do f
        return readline(f)
    end

    for _ in 1:50
        input = lookandsay(input)
    end
    return length(input)
end
