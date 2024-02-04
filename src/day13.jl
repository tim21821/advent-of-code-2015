using Combinatorics

const HAPPINESS_RE =
    r"^(?P<name1>[A-Z][a-z]+) would (?P<sign>gain|lose) (?P<amount>\d+) happiness units by sitting next to (?P<name2>[A-Z][a-z]+).$"

function part1()
    lines = open("input/day13.txt") do f
        return readlines(f)
    end

    names = Vector{String}()
    happinesschanges = Dict{Tuple{String,String},Int}()
    for line in lines
        m = match(HAPPINESS_RE, line)
        if !(m["name1"] in names)
            push!(names, m["name1"])
        end

        happinesschanges[(m["name1"], m["name2"])] =
            m["sign"] == "gain" ? parse(Int, m["amount"]) : -1 * parse(Int, m["amount"])
    end

    maximumchange = typemin(Int)
    for arrangement in permutations(names)
        change = 0
        for i in 1:length(arrangement)-1
            change += happinesschanges[(arrangement[i], arrangement[i+1])]
            change += happinesschanges[(arrangement[i+1], arrangement[i])]
        end
        change += happinesschanges[(arrangement[end], arrangement[1])]
        change += happinesschanges[(arrangement[1], arrangement[end])]
        maximumchange = max(maximumchange, change)
    end
    return maximumchange
end

function part2()
    lines = open("input/day13.txt") do f
        return readlines(f)
    end

    names = ["me"]
    happinesschanges = Dict{Tuple{String,String},Int}()
    for line in lines
        m = match(HAPPINESS_RE, line)
        if !(m["name1"] in names)
            push!(names, m["name1"])
            happinesschanges[(m["name1"], "me")] = 0
            happinesschanges[("me", m["name1"])] = 0
        end

        happinesschanges[(m["name1"], m["name2"])] =
            m["sign"] == "gain" ? parse(Int, m["amount"]) : -1 * parse(Int, m["amount"])
    end

    maximumchange = typemin(Int)
    for arrangement in permutations(names)
        change = 0
        for i in 1:length(arrangement)-1
            change += happinesschanges[(arrangement[i], arrangement[i+1])]
            change += happinesschanges[(arrangement[i+1], arrangement[i])]
        end
        change += happinesschanges[(arrangement[end], arrangement[1])]
        change += happinesschanges[(arrangement[1], arrangement[end])]
        maximumchange = max(maximumchange, change)
    end
    return maximumchange
end
