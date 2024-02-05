"""
Represent an ingredient by its properties.
"""
struct Ingredient
    capacity::Int
    durability::Int
    flavor::Int
    texture::Int
    calories::Int
end

const INGREDIENT_RE =
    r"(?P<name>[A-Z][a-z]+): capacity (?P<capacity>-?\d+), durability (?P<durability>-?\d), flavor (?P<flavor>-?\d+), texture (?P<texture>-?\d+), calories (?P<calories>-?\d+)"

"""
Construct an `Ingredient` from a string.
"""
function fromstring(str::AbstractString)
    m = match(INGREDIENT_RE, str)
    return Ingredient(
        parse(Int, m["capacity"]),
        parse(Int, m["durability"]),
        parse(Int, m["flavor"]),
        parse(Int, m["texture"]),
        parse(Int, m["calories"]),
    )
end

"""
Represent a cookie by the summed properties of the ingredients, weighted by the number of
teaspoons.
"""
mutable struct Cookie
    capacity::Int
    durability::Int
    flavor::Int
    texture::Int
    calories::Int
end

"""
Add `spoons` teaspoons of the `ingredient` to the `cookie` and adjust the properties
accordingly.
"""
function add_ingredient!(cookie::Cookie, ingredient::Ingredient, spoons::Int)
    cookie.capacity += ingredient.capacity * spoons
    cookie.durability += ingredient.durability * spoons
    cookie.flavor += ingredient.flavor * spoons
    cookie.texture += ingredient.texture * spoons
    return cookie.calories += ingredient.calories * spoons
end

"""
Return the total score of the `cookie`.
"""
function totalscore(cookie::Cookie)
    return max(0, cookie.capacity) *
           max(0, cookie.durability) *
           max(0, cookie.flavor) *
           max(0, cookie.texture)
end

"""
Return the total score of the `cookie` if it has exactly 500 calories. Return
`typemin(Int)` otherwise.
"""
function totalscore500calories(cookie::Cookie)
    if cookie.calories == 500
        return max(0, cookie.capacity) *
               max(0, cookie.durability) *
               max(0, cookie.flavor) *
               max(0, cookie.texture)
    else
        return typemin(Int)
    end
end

"""
Return all `Cookie`s that can be made using the `ingredients` when still having
`remainingspoons` to use.
"""
function getcookies(ingredients::Vector{Ingredient}, remainingspoons::Int)
    if length(ingredients) == 1
        ingredient = ingredients[1]
        return [
            Cookie(
                ingredient.capacity * remainingspoons,
                ingredient.durability * remainingspoons,
                ingredient.flavor * remainingspoons,
                ingredient.texture * remainingspoons,
                ingredient.calories * remainingspoons,
            ),
        ]
    end
    cookies = Vector{Cookie}()
    for i in 0:remainingspoons
        i_cookies = getcookies(ingredients[2:end], remainingspoons - i)
        for cookie in i_cookies
            add_ingredient!(cookie, ingredients[1], i)
        end
        append!(cookies, i_cookies)
    end
    return cookies
end

function part1()
    lines = open("input/day15.txt") do f
        return readlines(f)
    end

    ingredients = fromstring.(lines)
    cookies = getcookies(ingredients, 100)
    return maximum(totalscore, cookies)
end

function part2()
    lines = open("input/day15.txt") do f
        return readlines(f)
    end

    ingredients = fromstring.(lines)
    cookies = getcookies(ingredients, 100)
    return maximum(totalscore500calories, cookies)
end
