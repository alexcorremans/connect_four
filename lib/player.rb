class Player

  attr_reader :name, :symbol

  BLACK = "\u26AA".force_encoding("utf-8")
  WHITE = "\u26AB".force_encoding("utf-8")

  def initialize(player1=nil)
    @name = get_name(player1)
    @symbol = assign_symbol(player1)
  end

  private

  def get_name(player1)
    if player1.nil?
      puts "Enter first player name:"
      name = gets.chomp.capitalize
      while name.empty?
        puts "You didn't enter a name. Try again:"
        name = gets.chomp.capitalize
      end
    else
      puts "Enter second player name:"
      name = gets.chomp.capitalize
      while name.empty? || name == player1.name
        puts "You didn't enter a name, or that name is already taken. Try again:"
        name = gets.chomp.capitalize
      end
    end
    name
  end

  def assign_symbol(player1)
    if player1.nil?
      puts "Would you like to play black or white?"
      colour = gets.chomp.downcase
      while not (["black","white"].include? colour)
        puts "Please choose black or white."
        colour = gets.chomp.downcase
      end
      colour == "black" ? @symbol = BLACK : @symbol = WHITE
    else
      player1.symbol == WHITE ? @symbol = BLACK : @symbol = WHITE
    end
  end
end