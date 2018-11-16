require_relative 'cell'

class Cage

  def initialize
    @cells = []
    7.times do
      @cells.push([])
    end
  end

  def display
    puts " ___ ___ ___ ___ ___ ___ ___"
    5.downto(0) do |j|
      0.upto(6) do |i|
        if @cells[i][j].is_a?(Cell)
          print "|_#{@cells[i][j].symbol}_"
        else
          print "|___"
        end
      end
      puts "|"
    end
    puts "  1   2   3   4   5   6   7\n\n"
  end

  def modify(x, symbol)
    y = @cells[x].size
    if y != 6
      @cells[x].push(Cell.new(x,y,symbol))
      "success"
    else
      "fail"
    end
  end

  def winner?(symbol)
    winner = false
    @cells.each do |column|
      column.each do |cell|
        next if cell.symbol != symbol
        if (check(cell, "right") ||
          check(cell, "left") ||
          check(cell, "up") ||
          check(cell, "down") ||
          check(cell, "diagonal_right_up") ||
          check(cell, "diagonal_right_down") ||
          check(cell, "diagonal_left_up") ||
          check(cell, "diagonal_left_down"))
          winner = true
        end
        break if winner == true
      end
    end
    winner
  end

  def check(cell, direction, count=1)
    return true if count == 4
    if cell.method(direction).call.nil?
      return false
    else
      next_cell_location = cell.method(direction).call
    end
    x = next_cell_location[0]
    y = next_cell_location[1]
    return false if @cells[x][y].nil?
    return false if @cells[x][y].symbol != cell.symbol
    count += 1
    check(@cells[x][y], direction, count)
  end

  def full?
    @cells.all? do |column|
      column.size == 6
    end
  end
end