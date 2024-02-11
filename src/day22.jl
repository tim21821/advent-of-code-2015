using DataStructures

"""
Represent a player. The cooldown values start with the number of turns the effect will last
and decrease by one each turn till reaching 0.
"""
struct Player
    hitpoints::Int
    mana::Int
    armor::Int
    shieldcooldown::Int8
    poisoncooldown::Int8
    rechargecooldown::Int8
end

Player() = Player(50, 500, 0, 0, 0, 0)

"""
Represent a Boss.
"""
struct Boss
    hitpoints::Int
    damage::Int
end

function part1()
    lines = open("input/day22.txt") do f
        return readlines(f)
    end
    bosshitpoints = parse(Int, split(lines[1], ": ")[2])
    bossdamage = parse(Int, split(lines[2], ": ")[2])
    initialboss = Boss(bosshitpoints, bossdamage)

    queue = PriorityQueue{Tuple{Player,Boss,Int,Bool},Int}()
    enqueue!(queue, (Player(), initialboss, 0, true) => 0)
    while !isempty(queue)
        player, boss, manaspent, playersturn = dequeue!(queue)
        if boss.hitpoints <= 0
            return manaspent
        end
        if player.hitpoints <= 0
            continue
        end


        bosshitpoints = boss.hitpoints
        armor = player.armor
        mana = player.mana
        shieldcooldown = player.shieldcooldown
        poisoncooldown = player.poisoncooldown
        rechargecooldown = player.rechargecooldown
        if shieldcooldown > 0
            shieldcooldown -= 1
            if shieldcooldown == 0
                armor -= 7
            end
        end
        if poisoncooldown > 0
            bosshitpoints -= 3
            poisoncooldown -= 1
        end
        if rechargecooldown > 0
            mana += 101
            rechargecooldown -= 1
        end

        if playersturn
            # magic missile
            if mana >= 53
                queue[(
                    Player(
                        player.hitpoints,
                        mana - 53,
                        armor,
                        shieldcooldown,
                        poisoncooldown,
                        rechargecooldown,
                    ),
                    Boss(bosshitpoints - 4, boss.damage),
                    manaspent + 53,
                    false,
                )] = manaspent + 53
            end
            # drain
            if mana >= 73
                queue[(
                    Player(
                        player.hitpoints + 2,
                        mana - 73,
                        armor,
                        shieldcooldown,
                        poisoncooldown,
                        rechargecooldown,
                    ),
                    Boss(bosshitpoints - 2, boss.damage),
                    manaspent + 73,
                    false,
                )] = manaspent + 73
            end
            # shield
            if mana >= 113 && shieldcooldown == 0
                queue[(
                    Player(
                        player.hitpoints,
                        mana - 113,
                        armor + 7,
                        6,
                        poisoncooldown,
                        rechargecooldown,
                    ),
                    Boss(bosshitpoints, boss.damage),
                    manaspent + 113,
                    false,
                )] = manaspent + 113
            end
            # poison
            if mana >= 173 && poisoncooldown == 0
                queue[(
                    Player(
                        player.hitpoints,
                        mana - 173,
                        armor,
                        shieldcooldown,
                        6,
                        rechargecooldown,
                    ),
                    Boss(bosshitpoints, boss.damage),
                    manaspent + 173,
                    false,
                )] = manaspent + 173
            end
            # recharge
            if mana >= 229 && rechargecooldown == 0
                queue[(
                    Player(
                        player.hitpoints,
                        mana - 229,
                        armor,
                        shieldcooldown,
                        poisoncooldown,
                        5,
                    ),
                    Boss(bosshitpoints, boss.damage),
                    manaspent + 229,
                    false,
                )] = manaspent + 229
            end
        else
            queue[(
                Player(
                    player.hitpoints - max(1, boss.damage - armor),
                    mana,
                    armor,
                    shieldcooldown,
                    poisoncooldown,
                    rechargecooldown,
                ),
                Boss(bosshitpoints, boss.damage),
                manaspent,
                true,
            )] = manaspent
        end
    end
end

function part2()
    lines = open("input/day22.txt") do f
        return readlines(f)
    end
    bosshitpoints = parse(Int, split(lines[1], ": ")[2])
    bossdamage = parse(Int, split(lines[2], ": ")[2])
    initialboss = Boss(bosshitpoints, bossdamage)

    queue = PriorityQueue{Tuple{Player,Boss,Int,Bool},Int}()
    enqueue!(queue, (Player(), initialboss, 0, true) => 0)
    while !isempty(queue)
        player, boss, manaspent, playersturn = dequeue!(queue)
        if boss.hitpoints <= 0
            return manaspent
        end
        if player.hitpoints <= 0
            continue
        end


        bosshitpoints = boss.hitpoints
        armor = player.armor
        mana = player.mana
        shieldcooldown = player.shieldcooldown
        poisoncooldown = player.poisoncooldown
        rechargecooldown = player.rechargecooldown
        if shieldcooldown > 0
            shieldcooldown -= 1
            if shieldcooldown == 0
                armor -= 7
            end
        end
        if poisoncooldown > 0
            bosshitpoints -= 3
            poisoncooldown -= 1
        end
        if rechargecooldown > 0
            mana += 101
            rechargecooldown -= 1
        end

        if playersturn
            if player.hitpoints <= 1
                continue
            end
            # magic missile
            if mana >= 53
                queue[(
                    Player(
                        player.hitpoints - 1,
                        mana - 53,
                        armor,
                        shieldcooldown,
                        poisoncooldown,
                        rechargecooldown,
                    ),
                    Boss(bosshitpoints - 4, boss.damage),
                    manaspent + 53,
                    false,
                )] = manaspent + 53
            end
            # drain
            if mana >= 73
                queue[(
                    Player(
                        player.hitpoints + 1,
                        mana - 73,
                        armor,
                        shieldcooldown,
                        poisoncooldown,
                        rechargecooldown,
                    ),
                    Boss(bosshitpoints - 2, boss.damage),
                    manaspent + 73,
                    false,
                )] = manaspent + 73
            end
            # shield
            if mana >= 113 && shieldcooldown == 0
                queue[(
                    Player(
                        player.hitpoints - 1,
                        mana - 113,
                        armor + 7,
                        6,
                        poisoncooldown,
                        rechargecooldown,
                    ),
                    Boss(bosshitpoints, boss.damage),
                    manaspent + 113,
                    false,
                )] = manaspent + 113
            end
            # poison
            if mana >= 173 && poisoncooldown == 0
                queue[(
                    Player(
                        player.hitpoints - 1,
                        mana - 173,
                        armor,
                        shieldcooldown,
                        6,
                        rechargecooldown,
                    ),
                    Boss(bosshitpoints, boss.damage),
                    manaspent + 173,
                    false,
                )] = manaspent + 173
            end
            # recharge
            if mana >= 229 && rechargecooldown == 0
                queue[(
                    Player(
                        player.hitpoints - 1,
                        mana - 229,
                        armor,
                        shieldcooldown,
                        poisoncooldown,
                        5,
                    ),
                    Boss(bosshitpoints, boss.damage),
                    manaspent + 229,
                    false,
                )] = manaspent + 229
            end
        else
            queue[(
                Player(
                    player.hitpoints - max(1, boss.damage - armor),
                    mana,
                    armor,
                    shieldcooldown,
                    poisoncooldown,
                    rechargecooldown,
                ),
                Boss(bosshitpoints, boss.damage),
                manaspent,
                true,
            )] = manaspent
        end
    end
end
