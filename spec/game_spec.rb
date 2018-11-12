require './lib/game'

describe Game do

  let(:white) { Player::WHITE }
  let(:black) { Player::BLACK }
  let(:player1) { instance_double('Player', name: "One", symbol: white) }
  let(:player2) { instance_double('Player', name: "Two", symbol: black) }
  let(:game) { Game.new(player1,player2) }

  describe "#initialize" do
    it "creates an empty board and assigns it to an instance variable" do
      expect(game.instance_variable_get(:@board)).to be_a Board
    end

    it "has two players" do
      expect(game.instance_variable_get(:@player1)).to eql(player1)
      expect(game.instance_variable_get(:@player2)).to eql(player2)
    end
  end

  describe "#start_game" do
    it "asks which player would like to start the game and moves on to the first turn with that player" do
      allow_any_instance_of(Game).to receive(:gets).and_return("one")
    
    end
  end

  describe "#next_turn" do
    it "prints a victory message with the correct player and exits the program when the board has four symbols in a row" do
    end
  end

  describe "#choose_column" do
    it "fills the first empty row of the given column" do
    end

    it "notifies player if column is full" do
    end

    it "notifies player if input is invalid" do
    end
  end


end