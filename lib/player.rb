class Player

  attr_reader :name, :symbol

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
      while @name.empty? or @name == @@p1_name
        puts "You didn't enter a name, or that name is already taken. Try again:"
        @name = gets.chomp.capitalize
      end
    end
  end

  def assign_symbol
    if @@number_of_players == 1
      print "Would you like to play black or white? "
      symbol = gets.chomp.downcase
      while not (["black","white"].include? symbol)
        puts "Please choose black or white."
        symbol = gets.chomp.downcase
      end
      @@p1_symbol = symbol
      if symbol == "black"
        @symbol = "\u26AB".force_encoding('utf-8')
      else
        @symbol = "\u26AA".force_encoding('utf-8')
      end
    else
      @@p1_symbol == "black" ? @symbol = "\u26AA".force_encoding('utf-8') : @symbol = "\u26AB".force_encoding('utf-8')
    end
  end
end