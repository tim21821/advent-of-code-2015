"""
Represent a fighter, so either the player or the enemy (boss).
"""
mutable struct Fighter
    hitpoints::Int
    damage::Int
    armor::Int
end

Fighter() = Fighter(100, 0, 0)

Fighter(damage::Int, armor::Int) = Fighter(100, damage, armor)

"""
Let the `attacker` attack the `defender` and adjust the `defender`'s `hitpoints`
accordingly.
"""
function attack!(attacker::Fighter, defender::Fighter)
    damage = max(attacker.damage - defender.armor, 1)
    return defender.hitpoints -= damage
end

"""
Return whether the `player` will win against the `enemy`.
"""
function isplayerwinning(player::Fighter, enemy::Fighter)
    attack!(player, enemy)
    if enemy.hitpoints <= 0
        return true
    end
    return !isplayerwinning(enemy, player)
end

"""
Represent an item (weapon, armor or ring).
"""
struct Item
    cost::Int
    damage::Int
    armor::Int
end

"""
Equip the `fighter` with the `item` by adding its stats to the `fighter`'s stats.
"""
function equip!(fighter::Fighter, item::Item)
    fighter.damage += item.damage
    return fighter.armor += item.armor
end

const weapons =
    [Item(8, 4, 0), Item(10, 5, 0), Item(25, 6, 0), Item(40, 7, 0), Item(74, 8, 0)]

const armors = [
    Item(0, 0, 0),
    Item(13, 0, 1),
    Item(31, 0, 2),
    Item(53, 0, 3),
    Item(75, 0, 4),
    Item(102, 0, 5),
]

const rings = [
    Item(0, 0, 0),
    Item(0, 0, 0),
    Item(25, 1, 0),
    Item(50, 2, 0),
    Item(100, 3, 0),
    Item(20, 0, 1),
    Item(40, 0, 2),
    Item(80, 0, 3),
]

function part1()
    lines = open("input/day21.txt") do f
        return readlines(f)
    end

    enemyhitpoints = parse(Int, split(lines[1], ": ")[2])
    enemydamage = parse(Int, split(lines[2], ": ")[2])
    enemyarmor = parse(Int, split(lines[3], ": ")[2])
    mincost = typemax(Int)
    for weapon in weapons
        for armor in armors
            for (i, ring1) in enumerate(rings)
                for (j, ring2) in enumerate(rings)
                    if i == j
                        continue
                    end

                    enemy = Fighter(enemyhitpoints, enemydamage, enemyarmor)
                    player = Fighter()
                    equip!(player, weapon)
                    equip!(player, armor)
                    equip!(player, ring1)
                    equip!(player, ring2)
                    if isplayerwinning(player, enemy)
                        cost = weapon.cost + armor.cost + ring1.cost + ring2.cost
                        mincost = min(mincost, cost)
                    end
                end
            end
        end
    end
    return mincost
end

function part2()
    lines = open("input/day21.txt") do f
        return readlines(f)
    end

    enemyhitpoints = parse(Int, split(lines[1], ": ")[2])
    enemydamage = parse(Int, split(lines[2], ": ")[2])
    enemyarmor = parse(Int, split(lines[3], ": ")[2])
    maxcost = typemin(Int)
    for weapon in weapons
        for armor in armors
            for (i, ring1) in enumerate(rings)
                for (j, ring2) in enumerate(rings)
                    if i == j
                        continue
                    end

                    enemy = Fighter(enemyhitpoints, enemydamage, enemyarmor)
                    player = Fighter()
                    equip!(player, weapon)
                    equip!(player, armor)
                    equip!(player, ring1)
                    equip!(player, ring2)
                    if !isplayerwinning(player, enemy)
                        cost = weapon.cost + armor.cost + ring1.cost + ring2.cost
                        maxcost = max(maxcost, cost)
                    end
                end
            end
        end
    end
    return maxcost
end
