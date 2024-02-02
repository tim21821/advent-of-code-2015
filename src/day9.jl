using Combinatorics

gettrips(cities::Vector{String}) = [(cities[i], cities[i+1]) for i in 1:length(cities)-1]

function part1()
    lines = open("input/day9.txt") do f
        return readlines(f)
    end

    distances = Dict{Tuple{String,String},Int}()
    cities = Vector{String}()
    for line in lines
        cities_str, distance = split(line, " = ")
        city1, city2 = split(cities_str, " to ")
        distances[(city1, city2)] = parse(Int, distance)
        distances[(city2, city1)] = parse(Int, distance)
        if !(city1 in cities)
            push!(cities, city1)
        end
        if !(city2 in cities)
            push!(cities, city2)
        end
    end
    minroute = typemax(Int)
    for p in permutations(cities)
        trips = gettrips(p)
        routelength = sum([distances[t] for t in trips])
        minroute = min(minroute, routelength)
    end
    return minroute
end

function part2()
    lines = open("input/day9.txt") do f
        return readlines(f)
    end

    distances = Dict{Tuple{String,String},Int}()
    cities = Vector{String}()
    for line in lines
        cities_str, distance = split(line, " = ")
        city1, city2 = split(cities_str, " to ")
        distances[(city1, city2)] = parse(Int, distance)
        distances[(city2, city1)] = parse(Int, distance)
        if !(city1 in cities)
            push!(cities, city1)
        end
        if !(city2 in cities)
            push!(cities, city2)
        end
    end
    maxroute = 0
    for p in permutations(cities)
        trips = gettrips(p)
        routelength = sum([distances[t] for t in trips])
        maxroute = max(maxroute, routelength)
    end
    return maxroute
end
