require_relative 'board'

class Game

  def initialize(player1,player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
  end
end