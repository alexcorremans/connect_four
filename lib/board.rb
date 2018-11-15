class Board

  BLACK = "\u26AB".force_encoding("utf-8")
  WHITE = "\u26AA".force_encoding("utf-8")

  def initialize
    @cells = []
    7.times do
      @cells.push(['_','_','_','_','_','_'])
    end
  end

  def display
    puts " ___ ___ ___ ___ ___ ___ ___"
    5.downto(0) do |j|
      0.upto(6) do |i|
        print "|_#{@cells[i][j]}_"
      end
      puts "|"
    end
    puts "  1   2   3   4   5   6   7\n\n"
  end

  def modify(column, symbol)
    empty_row = @cells[column].find_index("_")
    if !empty_row.nil?
      @cells[column][empty_row] = symbol
      "success"
    else
      "fail"
    end
  end

  def winner?
    winner = false
    rows = [
      [@cells[0][0], @cells[1][0], @cells[2][0], @cells[3][0]],
      [@cells[0][1], @cells[1][1], @cells[2][1], @cells[3][1]],
      [@cells[0][2], @cells[1][2], @cells[2][2], @cells[3][2]],
      [@cells[0][3], @cells[1][3], @cells[2][3], @cells[3][3]],
      [@cells[0][4], @cells[1][4], @cells[2][4], @cells[3][4]],
      [@cells[0][5], @cells[1][5], @cells[2][5], @cells[3][5]],
      [@cells[1][0], @cells[2][0], @cells[3][0], @cells[4][0]],
      [@cells[1][1], @cells[2][1], @cells[3][1], @cells[4][1]],
      [@cells[1][2], @cells[2][2], @cells[3][2], @cells[4][2]],
      [@cells[1][3], @cells[2][3], @cells[3][3], @cells[4][3]],
      [@cells[1][4], @cells[2][4], @cells[3][4], @cells[4][4]],
      [@cells[1][5], @cells[2][5], @cells[3][5], @cells[4][5]],
      [@cells[2][0], @cells[3][0], @cells[4][0], @cells[5][0]],
      [@cells[2][1], @cells[3][1], @cells[4][1], @cells[5][1]],
      [@cells[2][2], @cells[3][2], @cells[4][2], @cells[5][2]],
      [@cells[2][3], @cells[3][3], @cells[4][3], @cells[5][3]],
      [@cells[2][4], @cells[3][4], @cells[4][4], @cells[5][4]],
      [@cells[2][5], @cells[3][5], @cells[4][5], @cells[5][5]],
      [@cells[3][0], @cells[4][0], @cells[5][0], @cells[6][0]],
      [@cells[3][1], @cells[4][1], @cells[5][1], @cells[6][1]],
      [@cells[3][2], @cells[4][2], @cells[5][2], @cells[6][2]],
      [@cells[3][3], @cells[4][3], @cells[5][3], @cells[6][3]],
      [@cells[3][4], @cells[4][4], @cells[5][4], @cells[6][4]],
      [@cells[3][5], @cells[4][5], @cells[5][5], @cells[6][5]]
    ]
    rows.each do |row|
      if row.all? { |cell| cell == "#{WHITE}" } || row.all? { |cell| cell == "#{BLACK}" }
        winner = true
        break
      end
    end
    columns = [
      [@cells[0][0],@cells[0][1],@cells[0][2],@cells[0][3]],
      [@cells[1][0],@cells[1][1],@cells[1][2],@cells[1][3]],
      [@cells[2][0],@cells[2][1],@cells[2][2],@cells[2][3]],
      [@cells[3][0],@cells[3][1],@cells[3][2],@cells[3][3]],
      [@cells[4][0],@cells[4][1],@cells[4][2],@cells[4][3]],
      [@cells[5][0],@cells[5][1],@cells[5][2],@cells[5][3]],
      [@cells[6][0],@cells[6][1],@cells[6][2],@cells[6][3]],
      [@cells[0][1],@cells[0][2],@cells[0][3],@cells[0][4]],
      [@cells[1][1],@cells[1][2],@cells[1][3],@cells[1][4]],
      [@cells[2][1],@cells[2][2],@cells[2][3],@cells[2][4]],
      [@cells[3][1],@cells[3][2],@cells[3][3],@cells[3][4]],
      [@cells[4][1],@cells[4][2],@cells[4][3],@cells[4][4]],
      [@cells[5][1],@cells[5][2],@cells[5][3],@cells[5][4]],
      [@cells[6][1],@cells[6][2],@cells[6][3],@cells[6][4]],
      [@cells[0][2],@cells[0][3],@cells[0][4],@cells[0][5]],
      [@cells[1][2],@cells[1][3],@cells[1][4],@cells[1][5]],
      [@cells[2][2],@cells[2][3],@cells[2][4],@cells[2][5]],
      [@cells[3][2],@cells[3][3],@cells[3][4],@cells[3][5]],
      [@cells[4][2],@cells[4][3],@cells[4][4],@cells[4][5]],
      [@cells[5][2],@cells[5][3],@cells[5][4],@cells[5][5]],
      [@cells[6][2],@cells[6][3],@cells[6][4],@cells[6][5]],
    ]
    columns.each do |column|
      if column.all? { |cell| cell == "#{WHITE}" } || column.all? { |cell| cell == "#{BLACK}" }
        winner = true
        break
      end
    end
    diagonals = [
      [@cells[0][0],@cells[1][1],@cells[2][2],@cells[3][3]],
      [@cells[1][0],@cells[2][1],@cells[3][2],@cells[4][3]],
      [@cells[2][0],@cells[3][1],@cells[4][2],@cells[5][3]],
      [@cells[3][0],@cells[4][1],@cells[5][2],@cells[6][3]],
      [@cells[0][1],@cells[1][2],@cells[2][3],@cells[3][4]],
      [@cells[1][1],@cells[2][2],@cells[3][3],@cells[4][4]],
      [@cells[2][1],@cells[3][2],@cells[4][3],@cells[5][4]],
      [@cells[3][1],@cells[4][2],@cells[5][3],@cells[6][4]],
      [@cells[0][2],@cells[1][3],@cells[2][4],@cells[3][5]],
      [@cells[1][2],@cells[2][3],@cells[3][4],@cells[4][5]],
      [@cells[2][2],@cells[3][3],@cells[4][4],@cells[5][5]],
      [@cells[3][2],@cells[4][3],@cells[5][4],@cells[6][5]],
      [@cells[0][5],@cells[1][4],@cells[2][3],@cells[3][2]],
      [@cells[1][5],@cells[2][4],@cells[3][3],@cells[4][2]],
      [@cells[2][5],@cells[3][4],@cells[4][3],@cells[5][2]],
      [@cells[3][5],@cells[4][4],@cells[5][3],@cells[6][2]],
      [@cells[0][4],@cells[1][3],@cells[2][2],@cells[3][1]],
      [@cells[1][4],@cells[2][3],@cells[3][2],@cells[4][1]],
      [@cells[2][4],@cells[3][3],@cells[4][2],@cells[5][1]],
      [@cells[3][4],@cells[4][3],@cells[5][2],@cells[6][1]],
      [@cells[0][3],@cells[1][2],@cells[2][1],@cells[3][0]],
      [@cells[1][3],@cells[2][2],@cells[3][1],@cells[4][0]],
      [@cells[2][3],@cells[3][2],@cells[4][1],@cells[5][0]],
      [@cells[3][3],@cells[4][2],@cells[5][1],@cells[6][0]],
    ]
    diagonals.each do |line|
      if line.all? { |cell| cell == "#{WHITE}" } || line.all? { |cell| cell == "#{BLACK}" }
        winner = true
        break
      end
    end
    winner
  end

  def full?
    @cells.all? do |column|
      column.none? do |cell|
        cell == "_"
      end
    end
  end
end