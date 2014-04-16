require 'pry'

class SudokuMaker
  CUBES = [[0..2, 0..2], [0..2, 3..5], [0..2, 6..8], 
           [3..5, 0..2], [3..5, 3..5], [3..5, 6..8],
           [6..8, 0..2], [6..8, 3..5], [6..8, 6..8]]

  attr_reader :cubits

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    @cubits = []
  end

  def fill
    CUBES.each_with_index do |c, i|
      x, y = c
      cube = cube(x,y)
      @cubits << fill_cube(cube, i)
    end
  end

  def modify_random_vars(cube, i)
    
  end

  def fill_cube(cube, i)
    @num = (1..9).to_a.shuffle
    @ran = (1..9).to_a.shuffle

    modify_random_vars(cube, i) if !@cubits.empty?

    cube = cube.flatten
    count = 0
    until count == 4
      y, x = @num.shift, @ran.shift
      if cube[x].nil?
        cube[x] = y
        count += 1
      else
        @num << y
        @ran << x
      end
    end

    return cube
  end

  def fill_row
    
  end

  def cube(x, y)
    @grid[x].map { |x| x[y] }
  end

  def upper_left
    @grid[0..2].map { |x| x[0..2]}
  end
end

grid = SudokuMaker.new
binding.pry

# a point on the grid belongs tooooo
# a cube, with 8 neighbors.
# two rows, with 8 neighbors

