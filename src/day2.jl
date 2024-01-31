"""
Represent a box by length, width and height.
"""
struct Box
    l::Int
    w::Int
    h::Int
end

"""
Construct a `Box` from an input string.
"""
function fromstring(s::AbstractString)
    dimensions = parse.(Int, split(s, 'x'))
    return Box(dimensions[1], dimensions[2], dimensions[3])
end

"""
Return the area of the needed wrapping paper for the `box`.
"""
function wrappingpaper(box::Box)
    sides = [box.l * box.w, box.w * box.h, box.h * box.l]
    return 2 * sum(sides) + minimum(sides)
end

"""
Return the length of the ribbon for the `box`.
"""
function ribbonlength(box::Box)
    return 2 * (box.l + box.w + box.h - max(box.l, box.w, box.h)) + box.l * box.w * box.h
end

function part1()
    lines = open("input/day2.txt") do f
        return readlines(f)
    end

    boxes = fromstring.(lines)
    return sum(wrappingpaper.(boxes))
end

function part2()
    lines = open("input/day2.txt") do f
        return readlines(f)
    end

    boxes = fromstring.(lines)
    return sum(ribbonlength.(boxes))
end

ans1 = part1()
println(ans1)
ans2 = part2()
println(ans2)
