class Board

  attr_reader :cells

  def initialize(player1,player2)
    @player1 = player1
    @player2 = player2
    @cells = []
    7.times do
      @cells.push(['_','_','_','_','_','_'])
    end
  end

  def display(cells)
    puts " ___ ___ ___ ___ ___ ___ ___"
    5.downto(0) do |j|
      0.upto(6) do |i|
        print "|_#{cells[i][j]}_"
      end
      puts "|"
    end
    puts ""
  end
end