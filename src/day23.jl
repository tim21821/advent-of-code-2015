function part1()
    lines = open("input/day23.txt") do f
        return readlines(f)
    end

    registers = Dict('a' => zero(UInt), 'b' => zero(UInt))
    i = 1
    while i <= length(lines)
        instruction = lines[i]
        if occursin("hlf", instruction)
            register = instruction[end]
            registers[register] ÷= 2
            i += 1
        elseif occursin("tpl", instruction)
            register = instruction[end]
            registers[register] *= 3
            i += 1
        elseif occursin("inc", instruction)
            register = instruction[end]
            registers[register] += 1
            i += 1
        elseif occursin("jmp", instruction)
            jump = parse(Int, instruction[5:end])
            i += jump
        elseif occursin("jie", instruction)
            register = instruction[5]
            jump = parse(Int, instruction[8:end])
            if registers[register] % 2 == 0
                i += jump
            else
                i += 1
            end
        elseif occursin("jio", instruction)
            register = instruction[5]
            jump = parse(Int, instruction[8:end])
            if registers[register] == 1
                i += jump
            else
                i += 1
            end
        end
    end
    return Int(registers['b'])
end

function part2()
    lines = open("input/day23.txt") do f
        return readlines(f)
    end

    registers = Dict('a' => one(UInt), 'b' => zero(UInt))
    i = 1
    while i <= length(lines)
        instruction = lines[i]
        if occursin("hlf", instruction)
            register = instruction[end]
            registers[register] ÷= 2
            i += 1
        elseif occursin("tpl", instruction)
            register = instruction[end]
            registers[register] *= 3
            i += 1
        elseif occursin("inc", instruction)
            register = instruction[end]
            registers[register] += 1
            i += 1
        elseif occursin("jmp", instruction)
            jump = parse(Int, instruction[5:end])
            i += jump
        elseif occursin("jie", instruction)
            register = instruction[5]
            jump = parse(Int, instruction[8:end])
            if registers[register] % 2 == 0
                i += jump
            else
                i += 1
            end
        elseif occursin("jio", instruction)
            register = instruction[5]
            jump = parse(Int, instruction[8:end])
            if registers[register] == 1
                i += jump
            else
                i += 1
            end
        end
    end
    return Int(registers['b'])
end
