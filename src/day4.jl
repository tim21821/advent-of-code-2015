using MD5

"""
Return whether `s` starts with five zeros.
"""
hasfiveleadingzeros(s::AbstractString) =
    s[1] == '0' && s[2] == '0' && s[3] == '0' && s[4] == '0' && s[5] == '0'

"""
Return whether `s` starts with six zeros.
"""
hassixleadingzeros(s::AbstractString) =
    s[1] == '0' && s[2] == '0' && s[3] == '0' && s[4] == '0' && s[5] == '0' && s[6] == '0'

function part1()
    input = open("input/day4.txt") do f
        return readline(f)
    end

    num = 1
    while !hasfiveleadingzeros(bytes2hex(md5(input * string(num))))
        num += 1
    end
    return num
end

function part2()
    input = open("input/day4.txt") do f
        return readline(f)
    end

    num = 1
    while !hassixleadingzeros(bytes2hex(md5(input * string(num))))
        num += 1
    end
    return num
end

ans1 = part1()
println(ans1)
ans2 = part2()
println(ans2)
