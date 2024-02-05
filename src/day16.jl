"""
Represent a Sue by her number in the list and her properties. Properties, that are not
remembered, are set to `-1`.
"""
struct Sue
    number::Int
    children::Int8
    cats::Int8
    samoyeds::Int8
    pomeranians::Int8
    akitas::Int8
    vizslas::Int8
    goldfish::Int8
    trees::Int8
    cars::Int8
    perfumes::Int8
end

"""
Construct a `Sue` from a string.
"""
function fromstring(str::AbstractString)
    sue, properties_str = split(str, ": "; limit = 2)
    number = parse(Int, sue[5:end])
    properties = split(properties_str, ", ")
    data = Dict{String,Int8}(
        "children" => -1,
        "cats" => -1,
        "samoyeds" => -1,
        "pomeranians" => -1,
        "akitas" => -1,
        "vizslas" => -1,
        "goldfish" => -1,
        "trees" => -1,
        "cars" => -1,
        "perfumes" => -1,
    )
    for property in properties
        label, count = split(property, ": ")
        data[label] = parse(Int8, count)
    end
    return Sue(
        number,
        data["children"],
        data["cats"],
        data["samoyeds"],
        data["pomeranians"],
        data["akitas"],
        data["vizslas"],
        data["goldfish"],
        data["trees"],
        data["cars"],
        data["perfumes"],
    )
end

"""
Return whether `sue` is the Sue from part 1.
"""
function isgiftsue1(sue::Sue)
    return (sue.children == 3 || sue.children == -1) &&
           (sue.cats == 7 || sue.cats == -1) &&
           (sue.samoyeds == 2 || sue.samoyeds == -1) &&
           (sue.pomeranians == 3 || sue.pomeranians == -1) &&
           (sue.akitas == 0 || sue.akitas == -1) &&
           (sue.vizslas == 0 || sue.vizslas == -1) &&
           (sue.goldfish == 5 || sue.goldfish == -1) &&
           (sue.trees == 3 || sue.trees == -1) &&
           (sue.cars == 2 || sue.cars == -1) &&
           (sue.perfumes == 1 || sue.perfumes == -1)
end

"""
Return whether `sue` is the Sue from part 2.
"""
function isgiftsue2(sue::Sue)
    return (sue.children == 3 || sue.children == -1) &&
           (sue.cats > 7 || sue.cats == -1) &&
           (sue.samoyeds == 2 || sue.samoyeds == -1) &&
           (sue.pomeranians < 3 || sue.pomeranians == -1) &&
           (sue.akitas == 0 || sue.akitas == -1) &&
           (sue.vizslas == 0 || sue.vizslas == -1) &&
           (sue.goldfish < 5 || sue.goldfish == -1) &&
           (sue.trees > 3 || sue.trees == -1) &&
           (sue.cars == 2 || sue.cars == -1) &&
           (sue.perfumes == 1 || sue.perfumes == -1)
end

function part1()
    lines = open("input/day16.txt") do f
        return readlines(f)
    end

    sues = fromstring.(lines)

    for sue in sues
        if isgiftsue1(sue)
            return sue.number
        end
    end
    return -1
end

function part2()
    lines = open("input/day16.txt") do f
        return readlines(f)
    end

    sues = fromstring.(lines)

    for sue in sues
        if isgiftsue2(sue)
            return sue.number
        end
    end
    return -1
end
