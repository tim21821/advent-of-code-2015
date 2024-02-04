"""
Represent a reindeer by its `speed`, the time it can fly and the time it needs to rest.
"""
struct Reindeer
    speed::Int
    flytime::Int
    resttime::Int
end

const INPUT_RE =
    r"[A-Z][a-z]+ can fly (?P<speed>\d+) km/s for (?P<flytime>\d+) seconds, but then must rest for (?P<resttime>\d+) seconds"

"""
Construct a `Reindeer` from a string input.
"""
function fromstring(str::AbstractString)
    m = match(INPUT_RE, str)
    return Reindeer(
        parse(Int, m["speed"]),
        parse(Int, m["flytime"]),
        parse(Int, m["resttime"]),
    )
end

"""
Return the distance the `reindeer` can travel in the given `time`.
"""
function distance(reindeer::Reindeer, time::Int)
    totalcycles, remainder = divrem(time, reindeer.flytime + reindeer.resttime)
    return (totalcycles * reindeer.flytime + min(remainder, reindeer.flytime)) *
           reindeer.speed
end

function part1()
    lines = open("input/day14.txt") do f
        return readlines(f)
    end

    reindeer = fromstring.(lines)
    return maximum(distance.(reindeer, 2503))
end

function part2()
    lines = open("input/day14.txt") do f
        return readlines(f)
    end

    reindeer = fromstring.(lines)
    points = zeros(Int, length(reindeer))
    for time in 1:2503
        distances = distance.(reindeer, time)
        maxindices = findall(e -> e == maximum(distances), distances)
        for i in maxindices
            points[i] += 1
        end
    end
    return maximum(points)
end
