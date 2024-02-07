"""
Return all divisors of `n`.
"""
function getdivisors(n::Int)
    i = 1
    divisors = Vector{Int}()
    while i <= sqrt(n)
        if n % i == 0
            push!(divisors, i)
            quotient = n ÷ i
            if i != quotient
                push!(divisors, quotient)
            end
        end
        i += 1
    end
    return divisors
end

"""
Get the number of present the house with number `housenum` gets.
"""
function getpresents(housenum::Int)
    divisors = getdivisors(housenum)
    return 10 * sum(divisors)
end

"""
Return the divisors of `n` where the quotient is maximum 50.
"""
function getdivisorsmax50(n::Int)
    i = 1
    divisors = Vector{Int}()
    for i in 1:50
        if n % i == 0
            push!(divisors, n ÷ i)
        end
    end
    return divisors
end

"""
Return the number of presents the house with number `housenum` gets when the elves are
only delivering to 50 houses each.
"""
function getpresentsmax50(housenum::Int)
    divisors = getdivisorsmax50(housenum)
    return 11 * sum(divisors)
end

function part1()
    input = open("input/day20.txt") do f
        return readline(f)
    end

    goal = parse(Int, input)
    housenum = 1
    while getpresents(housenum) < goal
        housenum += 1
    end
    return housenum
end

function part2()
    input = open("input/day20.txt") do f
        return readline(f)
    end

    goal = parse(Int, input)
    housenum = 1
    while getpresentsmax50(housenum) < goal
        housenum += 1
    end
    return housenum
end
