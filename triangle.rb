# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  hypoteneus, side1, side2 =
    if c > a || c > b
      [c,a,b]
    elsif b > a || b > c
      [b,a,c]
    else
      [a,b,c]
    end

  case
  # Throw error if any sides are equal to or less than 0
  when a <= 0 || b <= 0 || c <= 0
    raise TriangleError
  # Throw error if sides don't add up
  when side1 + side2 <= hypoteneus
    raise TriangleError
  when a == b && a == c
  	return :equilateral
  when a == b || a == c || c == b
  	return :isosceles
  else
  	return :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
