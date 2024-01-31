"""
Return whether `s` is nice according to part 1.
"""
function isnice1(s::AbstractString)
    if !any(s[i] == s[i+1] for i in 1:length(s)-1)
        return false
    end

    if occursin("ab", s) || occursin("cd", s) || occursin("pq", s) || occursin("xy", s)
        return false
    end

    vowelcount = count(c -> c in ['a', 'e', 'i', 'o', 'u'], s)
    return vowelcount >= 3
end

"""
Return whether `s` is nice according to part 2.
"""
function isnice2(s::AbstractString)
    if !any(s[i] == s[i+2] for i in 1:length(s)-2)
        return false
    end

    return any([occursin(s[i:i+1], s[i+2:end]) for i in 1:length(s)-2])
end

function part1()
    lines = open("input/day5.txt") do f
        return readlines(f)
    end

    return count(isnice1, lines)
end

function part2()
    lines = open("input/day5.txt") do f
        return readlines(f)
    end

    return count(isnice2, lines)
end

ans1 = part1()
println(ans1)
ans2 = part2()
println(ans2)
