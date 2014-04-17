require 'pry'

class SudokuMaker
  attr_reader :cubits
  SQUARES = [
             [0..2, 3..5, 6..8],
             [0..2, 3..5, 6..8],
             [0..2, 3..5, 6..8]
            ]

  def initialize
    @grid = Array.new(9) { Array.new(9) { '_' } }
    @cubits = []
  end

  def gen
    @grid.map.with_index do |row, index|
      @index = index
      @row   = row
      seed_numbers
    end
  end

  def seed_numbers
    @elements = (0..8).to_a.shuffle
    @random   = (1..9).to_a.shuffle
    count = 0

    until count == 4
      @elem = @elements.sample
      num  = @random.sample
      if @row[@elem] == "_" && (!@row.include?(num) && available?(num) )
        @row[@elem] = num
        @random.delete(num)
        count += 1
      end
    end

    return @row
  end

  def available?(num)
    !@grid.map { |row| row[@elem] }.include?(num) && not_in_square?(num)
  end

  def not_in_square?(num)
    !square.include?(num)
  end

  def square
    @grid[sqr[@index / 3]].map { |x| x[sqr[@elem / 3]] }.flatten
  end

  def sqr_map
    sqr[@index]
  end

  def sqr
    SQUARES[@index / 3]
  end

  def vertical
    
  end

  def show
    @grid.map { |x| x.join("|") }.join("\n")
  end
end

grid = SudokuMaker.new
grid.gen
puts grid.show



# a point on the grid belongs tooooo
# a cube, with 8 neighbors.
# two rows, with 8 neighbors

