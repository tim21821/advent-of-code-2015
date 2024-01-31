"""
Return the coordinates x1, y1 (from start), x2, y2 (from stop).
"""
function getcoordinates(start::AbstractString, stop::AbstractString)
    x1, y1 = parse.(Int, split(start, ',')) .+ 1
    x2, y2 = parse.(Int, split(stop, ',')) .+ 1
    return x1, y1, x2, y2
end

function part1()
    lines = open("input/day6.txt") do f
        return readlines(f)
    end

    grid = fill(false, 1000, 1000)
    for line in lines
        if occursin("turn on", line)
            start, stop = split(line[9:end], " through ")
            x1, y1, x2, y2 = getcoordinates(start, stop)
            for x in x1:x2
                for y in y1:y2
                    grid[y, x] = true
                end
            end
        elseif occursin("turn off", line)
            start, stop = split(line[10:end], " through ")
            x1, y1, x2, y2 = getcoordinates(start, stop)
            for x in x1:x2
                for y in y1:y2
                    grid[y, x] = false
                end
            end
        elseif occursin("toggle", line)
            start, stop = split(line[8:end], " through ")
            x1, y1, x2, y2 = getcoordinates(start, stop)
            for x in x1:x2
                for y in y1:y2
                    grid[y, x] = !(grid[y, x])
                end
            end
        end
    end
    return count(grid)
end

function part2()
    lines = open("input/day6.txt") do f
        return readlines(f)
    end

    grid = zeros(Int, 1000, 1000)
    for line in lines
        if occursin("turn on", line)
            start, stop = split(line[9:end], " through ")
            x1, y1, x2, y2 = getcoordinates(start, stop)
            for x in x1:x2
                for y in y1:y2
                    grid[y, x] += 1
                end
            end
        elseif occursin("turn off", line)
            start, stop = split(line[10:end], " through ")
            x1, y1, x2, y2 = getcoordinates(start, stop)
            for x in x1:x2
                for y in y1:y2
                    if grid[y, x] > 0
                        grid[y, x] -= 1
                    end
                end
            end
        elseif occursin("toggle", line)
            start, stop = split(line[8:end], " through ")
            x1, y1, x2, y2 = getcoordinates(start, stop)
            for x in x1:x2
                for y in y1:y2
                    grid[y, x] += 2
                end
            end
        end
    end
    return sum(grid)
end

ans1 = part1()
println(ans1)
ans2 = part2()
println(ans2)
