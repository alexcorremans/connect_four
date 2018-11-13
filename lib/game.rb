require_relative 'board'
require_relative 'player'

class Game

  attr_accessor :board, :player1, :player2

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
    display_players
  end

  def start
    puts "Who would like to start?"
    name = gets.chomp.capitalize
    while !(name == @player1.name || name == @player2.name)
      puts "Invalid player name. Try again:"
      name = gets.chomp.capitalize
    end
    puts "#{name} starts!"
    name == @player1.name ? play(@player1) : play(@player2)
  end

  private

  def display_players
    puts "\nPlayers:\n#{@player1.name} - #{@player1.symbol}\n#{@player2.name} - #{@player2.symbol}\n\n"
  end
  
  def play(player)

  end

  
  
end