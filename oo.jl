struct Point
    x::Float64
    y::Float64
end

mypoint = Point(5,7)

mypoint.x

mypoint.x = 3.0

mutable struct Starship
    name::String
    location::Point
end

ship = Starship("Enterprise", Point(5,7))

ship.location = Point(6,8)

Starship(name, x, y) = Starship(name, Point(x,y))

ship2 = Starship("Nature Evolution", 10, 2)

#internal constructor
mutable struct FancyStarship
    name::String
    location::Point
    FancyStarship(name, x, y) = new(name, Point(x, y))
end

ship3 = FancyStarship("blackhole", 12, 9)

#methods
function move!(starship::Starship, heading, distance)
    x = distance * cosd(heading)
    y = distance * sind(heading)
    old = starship.location
    starship.location = Point(old.x + x, old.y + y)
end

move!(ship2, 15, 30)

struct Rectangle
    width::Float64
    height::Float64
end
width(r::Rectangle) = r.width
height(r::Rectangle) = r.height

struct Square
    length::Float64
end

width(s::Square) = s.length
height(s::Square) = s.length

area(shape) = width(shape) * height(shape)

r = Rectangle(3,4)
s = Square(3)

@show area(r)
@show area(s)

# polymorphism
abstract type Shape end
combine_area(a::Shape, b::Shape) = area(a) + area(b)
combine_areas(l) = sum(map(area, l))

struct Circle <: Shape
    diameter::Float64
end

radius(c::Circle) = c.diameter / 2
area(c::Circle) = π * radius(c) ^2

abstract type AbstractRectangle <: Shape end
area(r::AbstractRectangle) = width(r) * height(r)

struct Rectangles <: AbstractRectangle
    width::Float64
    height::Float64
end
width(r::Rectangles) = r.width
height(r::Rectangles) = r.height

struct Squares <: AbstractRectangle
    length::Float64
end
width(s::Squares) = s.length
height(s::Squares) = s.length

c = Circle(3)
s = Squares(3)
r = Rectangles(3,2)

@show combine_area(c,s)
