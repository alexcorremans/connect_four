require_relative 'lib/game'

puts "Let's play Connect Four!"

cage = Cage.new
player1 = Player.new
player2 = Player.new(player1)

game = Game.new(cage, player1, player2)
game.start