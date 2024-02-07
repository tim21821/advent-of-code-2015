using Random

"""
Replace all occurences of `needle` in `str` with `replacement`.
"""
function substitute(
    str::AbstractString,
    needle::AbstractString,
    replacement::AbstractString,
)
    replaced = Vector{String}()
    for position in findall(needle, str)
        push!(replaced, str[1:first(position)-1] * replacement * str[last(position)+1:end])
    end
    return replaced
end

function part1()
    lines = open("input/day19.txt") do f
        return readlines(f)
    end

    replacements = Vector{Tuple{String,String}}()
    for line in lines[1:end-2]
        s1, s2 = split(line, " => ")
        push!(replacements, (s1, s2))
    end

    startingmolecule = lines[end]
    molecules = Set{String}()
    for replacement in replacements
        union!(molecules, substitute(startingmolecule, replacement[1], replacement[2]))
    end
    return length(molecules)
end

function part2()
    lines = open("input/day19.txt") do f
        return readlines(f)
    end

    replacements = Vector{Tuple{String,String}}()
    for line in lines[1:end-2]
        s1, s2 = split(line, " => ")
        push!(replacements, (s1, s2))
    end

    medicine = lines[end]
    target = medicine
    steps = 0
    while target != "e"
        temp = target
        for (s1, s2) in replacements
            if !(occursin(s2, target))
                continue
            end

            target = replace(target, s2 => s1; count = 1)
            steps += 1
        end

        if temp == target
            target = molecule
            steps = 0
            shuffle!(replacements)
        end
    end
    return steps
end
