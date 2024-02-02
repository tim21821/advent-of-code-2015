isnumber(s::AbstractString) = all(isdigit, s)

function part1()
    lines = open("input/day7.txt") do f
        return readlines(f)
    end

    wires = Dict{String,UInt16}()
    while !isempty(lines)
        remaininglines = Vector{String}()
        for line in lines
            instruction, wire = split(line, " -> ")
            if isnumber(instruction)
                wires[wire] = parse(UInt16, instruction)
            elseif startswith(instruction, "NOT")
                if isnumber(instruction[5:end])
                    wires[wire] = ~parse(UInt16, instruction[5:end])
                elseif instruction[5:end] in keys(wires)
                    wires[wire] = ~wires[instruction[5:end]]
                else
                    push!(remaininglines, line)
                end
            elseif occursin("LSHIFT", instruction)
                source, shift = split(instruction, " LSHIFT ")
                if isnumber(source)
                    wires[wire] = parse(UInt16, source) << parse(Int, shift)
                elseif source in keys(wires)
                    wires[wire] = wires[source] << parse(Int, shift)
                else
                    push!(remaininglines, line)
                end
            elseif occursin("RSHIFT", instruction)
                source, shift = split(instruction, " RSHIFT ")
                if isnumber(source)
                    wires[wire] = parse(UInt16, source) >> parse(Int, shift)
                elseif source in keys(wires)
                    wires[wire] = wires[source] >> parse(Int, shift)
                else
                    push!(remaininglines, line)
                end
            elseif occursin("AND", instruction)
                source1, source2 = split(instruction, " AND ")
                if isnumber(source1) && isnumber(source2)
                    wires[wire] = parse(UInt16, source1) & parse(UInt16, source2)
                elseif isnumber(source1) && source2 in keys(wires)
                    wires[wire] = parse(UInt16, source1) & wires[source2]
                elseif source1 in keys(wires) && isnumber(source2)
                    wires[wire] = wires[source1] & parse(UInt16, source2)
                elseif source1 in keys(wires) && source2 in keys(wires)
                    wires[wire] = wires[source1] & wires[source2]
                else
                    push!(remaininglines, line)
                end
            elseif occursin("OR", instruction)
                source1, source2 = split(instruction, " OR ")
                if isnumber(source1) && isnumber(source2)
                    wires[wire] = parse(UInt16, source1) | parse(UInt16, source2)
                elseif isnumber(source1) && source2 in keys(wires)
                    wires[wire] = parse(UInt16, source1) | wires[source2]
                elseif source1 in keys(wires) && isnumber(source2)
                    wires[wire] = wires[source1] | parse(UInt16, source2)
                elseif source1 in keys(wires) && source2 in keys(wires)
                    wires[wire] = wires[source1] | wires[source2]
                else
                    push!(remaininglines, line)
                end
            else
                if instruction in keys(wires)
                    wires[wire] = wires[instruction]
                else
                    push!(remaininglines, line)
                end
            end
        end
        lines = remaininglines
    end
    return wires["a"]
end

isnumber(s::AbstractString) = all(isdigit, s)

function part2()
    lines = open("input/day7.txt") do f
        return readlines(f)
    end

    wires = Dict{String,UInt16}()
    b = part1()
    wires["b"] = b
    while !isempty(lines)
        remaininglines = Vector{String}()
        for line in lines
            instruction, wire = split(line, " -> ")
            if wire == "b"
                continue
            end
            if isnumber(instruction)
                wires[wire] = parse(UInt16, instruction)
            elseif startswith(instruction, "NOT")
                if isnumber(instruction[5:end])
                    wires[wire] = ~parse(UInt16, instruction[5:end])
                elseif instruction[5:end] in keys(wires)
                    wires[wire] = ~wires[instruction[5:end]]
                else
                    push!(remaininglines, line)
                end
            elseif occursin("LSHIFT", instruction)
                source, shift = split(instruction, " LSHIFT ")
                if isnumber(source)
                    wires[wire] = parse(UInt16, source) << parse(Int, shift)
                elseif source in keys(wires)
                    wires[wire] = wires[source] << parse(Int, shift)
                else
                    push!(remaininglines, line)
                end
            elseif occursin("RSHIFT", instruction)
                source, shift = split(instruction, " RSHIFT ")
                if isnumber(source)
                    wires[wire] = parse(UInt16, source) >> parse(Int, shift)
                elseif source in keys(wires)
                    wires[wire] = wires[source] >> parse(Int, shift)
                else
                    push!(remaininglines, line)
                end
            elseif occursin("AND", instruction)
                source1, source2 = split(instruction, " AND ")
                if isnumber(source1) && isnumber(source2)
                    wires[wire] = parse(UInt16, source1) & parse(UInt16, source2)
                elseif isnumber(source1) && source2 in keys(wires)
                    wires[wire] = parse(UInt16, source1) & wires[source2]
                elseif source1 in keys(wires) && isnumber(source2)
                    wires[wire] = wires[source1] & parse(UInt16, source2)
                elseif source1 in keys(wires) && source2 in keys(wires)
                    wires[wire] = wires[source1] & wires[source2]
                else
                    push!(remaininglines, line)
                end
            elseif occursin("OR", instruction)
                source1, source2 = split(instruction, " OR ")
                if isnumber(source1) && isnumber(source2)
                    wires[wire] = parse(UInt16, source1) | parse(UInt16, source2)
                elseif isnumber(source1) && source2 in keys(wires)
                    wires[wire] = parse(UInt16, source1) | wires[source2]
                elseif source1 in keys(wires) && isnumber(source2)
                    wires[wire] = wires[source1] | parse(UInt16, source2)
                elseif source1 in keys(wires) && source2 in keys(wires)
                    wires[wire] = wires[source1] | wires[source2]
                else
                    push!(remaininglines, line)
                end
            else
                if instruction in keys(wires)
                    wires[wire] = wires[instruction]
                else
                    push!(remaininglines, line)
                end
            end
        end
        lines = remaininglines
    end
    return wires["a"]
end

ans1 = Int32(part1())
println(ans1)
ans2 = Int32(part2())
println(ans2)
