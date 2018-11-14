class Board

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
end