require_relative 'board'
require_relative 'player'

class Game
  
  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def start
    display_players
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
    @board.display
    choice = choose_column
    try = @board.modify(choice,player.symbol)
    until try == "success"
      puts "That column's already full! Try another one.\n"
      choice = choose_column
      try = @board.modify(choice,player.symbol)
    end
    next_turn(player)
  end

  def choose_column
    puts "Please enter a column number between 1 and 7:"
    column_number = gets.chomp
    while !column_number.to_i.between?(1, 7)
      puts "That's not a number between 1 and 7. Try again:"
      column_number = gets.chomp
    end
    choice = (column_number.to_i) - 1
  end

  def next_turn(player)
    if @board.winner?
      victory(player)
    elsif @board.full?
      full_board
    else
      puts "\nIt's your turn, #{player == @player1 ? @player2.name : @player1.name}!"
      player == @player1 ? play(@player2) : play(@player1)
    end
  end

  def victory(player)
    puts "The winner is #{player.name}. Congratulations!"
    exit
  end

  def full_board
    puts "The board is full, and no one won. Sorry!"
    exit
  end  
end