"""
Return the number of adjacent lights that are on. If `pos` is on the edge, missing lights
are counted as off.
"""
function countneighbors(lights::Matrix{Bool}, pos::CartesianIndex{2})
    counter = 0
    for y in pos[1]-1:pos[1]+1
        for x in pos[2]-1:pos[2]+1
            neighborpos = CartesianIndex(y, x)
            if checkbounds(Bool, lights, neighborpos) &&
               neighborpos != pos &&
               lights[neighborpos]
                counter += 1
            end
        end
    end
    return counter
end

"""
Update all `lights` according to part 1.
"""
function updatelights1!(lights::Matrix{Bool})
    currentstate = copy(lights)
    for (y, row) in enumerate(eachrow(lights))
        for (x, l) in enumerate(row)
            neighborcount = countneighbors(currentstate, CartesianIndex(y, x))
            if l && !(neighborcount == 2 || neighborcount == 3)
                lights[y, x] = false
            elseif !l && neighborcount == 3
                lights[y, x] = true
            end
        end
    end
end

"""
Update all `lights` according to part 2.
"""
function updatelights2!(lights::Matrix{Bool})
    currentstate = copy(lights)
    for (y, row) in enumerate(eachrow(lights))
        for (x, l) in enumerate(row)
            if (y == 1 || y == 100) && (x == 1 || x == 100)
                continue
            end

            neighborcount = countneighbors(currentstate, CartesianIndex(y, x))
            if l && !(neighborcount == 2 || neighborcount == 3)
                lights[y, x] = false
            elseif !l && neighborcount == 3
                lights[y, x] = true
            end
        end
    end
end

function part1()
    lines = open("input/day18.txt") do f
        return readlines(f)
    end

    lights = fill(false, 100, 100)
    for (y, line) in enumerate(lines)
        for (x, c) in enumerate(line)
            lights[y, x] = c == '#'
        end
    end

    for _ in 1:100
        updatelights1!(lights)
    end
    return count(lights)
end

function part2()
    lines = open("input/day18.txt") do f
        return readlines(f)
    end

    lights = fill(false, 100, 100)
    for (y, line) in enumerate(lines)
        for (x, c) in enumerate(line)
            lights[y, x] = c == '#'
        end
    end

    for _ in 1:100
        updatelights2!(lights)
    end
    return count(lights)
end
