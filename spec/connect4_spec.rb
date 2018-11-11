require './lib/player'
require './lib/board'



describe Player do

  describe "#initialize" do
    it "creates a first player and assigns a name and a symbol based on user input" do
      # player1 defined globally so it can be referred to in the second test
      $player1 = Player.new
      expect($player1.name).not_to be_nil
      expect($player1.symbol).to eql("\u26AA".force_encoding('utf-8')).or(eql("\u26AB".force_encoding('utf-8')))
    end

    it "creates a second player and assigns a name based on user input and the remaining symbol based on the first player's choice" do
      player2 = Player.new
      expect(player2.name).not_to be_nil
      if $player1.symbol == "\u26AA".force_encoding('utf-8')
        expect(player2.symbol).to eql("\u26AB".force_encoding('utf-8'))
      else
        expect(player2.symbol).to eql("\u26AA".force_encoding('utf-8'))
      end
    end
  end
end

describe Board do

  let(:player1) { double("Test player 1", name: "Tester 1", symbol: "\u26AA".force_encoding('utf-8')) }
  let(:player2) { double("Test player 2", name: "Tester 2", symbol: "\u26AB".force_encoding('utf-8')) }
  let(:board) { Board.new(player1,player2) }

  describe "#initialize" do


  end
end
