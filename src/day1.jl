function part1()
    input = open("input/day1.txt") do f
        return readline(f)
    end

    floor = 0
    for c in input
        if c == '('
            floor += 1
        elseif c == ')'
            floor -= 1
        end
    end
    return floor
end

function part2()
    input = open("input/day1.txt") do f
        return readline(f)
    end

    floor = 0
    for (i, c) in enumerate(input)
        if c == '('
            floor += 1
        elseif c == ')'
            floor -= 1
        end
        if floor == -1
            return i
        end
    end
end

ans1 = part1()
println(ans1)
ans2 = part2()
println(ans2)
