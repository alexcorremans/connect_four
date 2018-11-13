require './lib/game'

describe Game do

  before do
    allow($stdout).to receive(:write)
  end

  let(:white) { Player::WHITE }
  let(:black) { Player::BLACK }
  let(:board) { Board.new }
  let(:player1) { instance_double('Player', name: "One", symbol: black) }
  let(:player2) { instance_double('Player', name: "Two", symbol: white) }
  let(:game) { Game.new(board, player1, player2) }

  describe "#initialize" do

    before do
      allow_any_instance_of(Game).to receive(:display_players)
    end

    it "takes a board parameter and assigns it to an instance variable" do
      expect(game.instance_variable_get(:@board)).to eql(board)
    end

    it "creates two players and assigns them to instance variables" do
      expect(game.instance_variable_get(:@player1)).to eql(player1)
      expect(game.instance_variable_get(:@player2)).to eql(player2)
    end

    it "calls the #display_players method" do
      expect(game).to have_received(:display_players)
    end
    
  end

  describe "#display_players" do
    it "displays the players' chosen names and symbols" do
      # not using the usual game variable here to prevent #display_players from being called twice
      new_game = Game.new(board, player1, player2)
      expect{ new_game.send(:display_players) }.to output(
        "\nPlayers:\n#{player1.name} - #{player1.symbol}\n#{player2.name} - #{player2.symbol}\n\n"
      ).to_stdout
    end
  end

  describe "#start" do
    it "asks which player would like to start the game" do
      allow(game).to receive(:gets).and_return("one\n")
      expect{ game.send(:start) }.to output(
        "Who would like to start?\n" +
        "#{player1.name} starts!\n"
      ).to_stdout    
    end

    it "tells you if input was invalid and prompts again" do
      allow(game).to receive(:gets).and_return("nobody\n", "one\n")
      expect{ game.send(:start) }.to output(
        "Who would like to start?\n" +
        "Invalid player name. Try again:\n" +
        "#{player1.name} starts!\n"
      ).to_stdout
    end

    it "calls the play method with the correct player" do
      allow(game).to receive(:gets).and_return("two\n")
      allow(game).to receive(:play)
      game.send(:start)
      expect(game).to have_received(:play).with(player2)
    end
  end

  describe "#play" do
    it "calls #choose_column with the correct player" do
      allow(game).to receive(:choose_column)
      game.send(:play, player1)
      expect(game).to have_received(:choose_column).with(player1)
    end

  end

=begin

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
=end


end