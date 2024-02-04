"""
Increment the `password` in-place.
"""
function incrementpassword!(password::Vector{Char})
    for i in length(password):-1:1
        if password[i] == 'z'
            password[i] = 'a'
            continue
        end
        password[i] += 1
        return
    end
end

"""
Return whether `password` includes one increasing straight of at least three letters.
"""
function hasthreeascendingcharacters(password::Vector{Char})
    return any(
        i -> password[i] + 2 == password[i+1] + 1 == password[i+2],
        1:length(password)-2,
    )
end

"""
Return whether `password` contains at least two different, non-overlapping pairs of
letters.
"""
function notoverlappingpairs(password::Vector{Char})
    counter = 0
    i = 1
    while i < length(password)
        if password[i] == password[i+1]
            counter += 1
            i += 2
        else
            i += 1
        end
    end
    return counter
end

"""
Return whether `password` is a valid password.
"""
function isvalidpassword(password::Vector{Char})
    return hasthreeascendingcharacters(password) &&
           notoverlappingpairs(password) >= 2 &&
           !('i' in password || 'o' in password || 'l' in password)
end

function part1()
    input = open("input/day11.txt") do f
        return readline(f)
    end

    password = collect(input)
    while !isvalidpassword(password)
        incrementpassword!(password)
    end
    return join(password)
end

function part2()
    password = collect(part1())
    incrementpassword!(password)
    while !isvalidpassword(password)
        incrementpassword!(password)
    end
    return join(password)
end
