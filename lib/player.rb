class Player

  attr_reader :name, :symbol

  BLACK = "\u26AB".force_encoding('utf-8')
  WHITE = "\u26AA".force_encoding('utf-8')

  def initialize
    if defined?(@@number_of_players)
      @@number_of_players += 1
    else
      @@number_of_players = 1
    end
    get_name
    assign_symbol    
  end

  private

  def get_name
    if @@number_of_players == 1
      puts "Enter first player name:"
      @name = gets.chomp.capitalize
      while @name.empty?
        puts "You didn't enter a name. Try again:"
        @name = gets.chomp.capitalize
      end
      @@p1_name = @name
    else
      puts "Enter second player name:"
      @name = gets.chomp.capitalize
      while @name.empty? || @name == @@p1_name
        puts "You didn't enter a name, or that name is already taken. Try again:"
        @name = gets.chomp.capitalize
      end
    end
  end

  def assign_symbol
    if @@number_of_players == 1
      print "Would you like to play black or white? "
      colour = gets.chomp.downcase
      while not (["black","white"].include? colour)
        puts "Please choose black or white."
        colour = gets.chomp.downcase
      end
      @@p1_symbol = colour
      if colour == "black"
        @symbol = BLACK
      else
        @symbol = WHITE
      end
    else
      @@p1_symbol == "black" ? @symbol = WHITE : @symbol = BLACK
    end
  end
end