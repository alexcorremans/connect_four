require_relative 'lib/player'
require_relative 'lib/game'

puts "Let's play Connect Four!"

player1 = Player.new
player2 = Player.new(player1)
puts "\nPlayers:\n#{player1.name} - #{player1.symbol}\n#{player2.name} - #{player2.symbol}\n"

game = Game.new(player1,player2).start_game
