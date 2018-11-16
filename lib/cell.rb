class Cell
  
  attr_reader :symbol
  
  def initialize(x,y,symbol)
    @x = x
    @y = y
    @symbol = symbol
  end

  def right
    [@x+1,@y] if valid_coordinates?(@x+1,@y)
  end

  def left
    [@x-1,@y] if valid_coordinates?(@x-1,@y)
  end

  def up
    [@x,@y+1] if valid_coordinates?(@x,@y+1)
  end

  def down
    [@x,@y-1] if valid_coordinates?(@x,@y-1)
  end

  def diagonal_right_up
    [@x+1,@y+1] if valid_coordinates?(@x+1,@y+1)
  end

  def diagonal_right_down
    [@x+1,@y-1] if valid_coordinates?(@x+1,@y-1)
  end

  def diagonal_left_up
    [@x-1,@y+1] if valid_coordinates?(@x-1,@y+1)
  end

  def diagonal_left_down
    [@x-1,@y-1] if valid_coordinates?(@x-1,@y-1)
  end
  
  private

  def valid_coordinates?(x,y)
    x.between?(0,6) && y.between?(0,5)
  end
end