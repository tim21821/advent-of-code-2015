const INPUT_RE =
    r"^To continue, please consult the code grid in the manual\.  Enter the code at row (?P<row>\d+), column (?P<column>\d+)\.$"

function part1()
    input = open("input/day25.txt") do f
        return readline(f)
    end

    m = match(INPUT_RE, input)
    row = parse(Int, m["row"])
    column = parse(Int, m["column"])
    codes = Vector{Int}()
    current = CartesianIndex(1, 1)
    push!(codes, 20151125)
    while current != CartesianIndex(row, column)
        if current[1] == 1
            current = CartesianIndex(current[2] + 1, 1)
        else
            current = CartesianIndex(current[1] - 1, current[2] + 1)
        end

        newcode = (codes[end] * 252533) % 33554393
        push!(codes, newcode)
    end
    return codes[end]
end
