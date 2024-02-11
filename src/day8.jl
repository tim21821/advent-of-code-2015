"""
Count the number of escaped backslashed in `str`.
"""
function countbackslash(str::AbstractString)
    return count(i -> str[i:i+1] == "\\\\", 1:length(str)-1)
end

"""
Count the number of escaped quotes in `str`.
"""
function countquote(str::AbstractString)
    return count(i -> str[i:i+1] == "\\\"", 1:length(str)-1)
end

"""
Count the number of hex escapes in `str`.
"""
function counthexescapes(str::AbstractString)
    return count(i -> str[i:i+1] == "\\x" && (i == 1 || str[i-1] != '\\'), 1:length(str)-1)
end

"""
Return the number of characters in memory of `str`.
"""
function charactersinmemory(str::AbstractString)
    return length(str) - 2 - countbackslash(str) - countquote(str) -
           3 * counthexescapes(str)
end

function part1()
    lines = open("input/day8.txt") do f
        return readlines(f)
    end

    return sum(length.(lines)) - sum(charactersinmemory.(lines))
end

function part2()
    lines = open("input/day8.txt") do f
        return readlines(f)
    end

    return sum([
        2 +
        count(i -> str[i] == '\\', 1:length(str)) +
        count(i -> str[i] == '"', 1:length(str)) for str in lines
    ])
end
