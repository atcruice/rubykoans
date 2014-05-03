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
  case analyse_triangle(a, b, c)
  when 1
    :equilateral
  when 2
    :isosceles
  when 3
    :scalene
  else
    puts 'WAT!'
  end
end

def analyse_triangle(*sides)
  check_triangle(sides)
  sides.uniq.length
end

def check_triangle(sides)
  fail TriangleError if sides.length != 3
  sides.map { |side| fail TriangleError if side < 1 }
  # way to do this without mutation?
  sides.sort!
  fail TriangleError unless sides[0] + sides[1] > sides[2]
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
