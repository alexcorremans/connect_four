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
    it "receives a board and assigns it to an instance variable" do
      expect(game.instance_variable_get(:@board)).to eql(board)
    end

    it "receives two players and assigns them to instance variables" do
      expect(game.instance_variable_get(:@player1)).to eql(player1)
      expect(game.instance_variable_get(:@player2)).to eql(player2)
    end    
  end

  describe "#display_players" do
    it "displays the players' chosen names and symbols" do
      expect{ game.send(:display_players) }.to output(
        "\nPlayers:\n#{player1.name} - #{player1.symbol}\n#{player2.name} - #{player2.symbol}\n\n"
      ).to_stdout
    end
  end

  describe "#start" do

    before(:each) do
      allow(game).to receive(:play)
    end

    it "calls #display_players" do
      allow(game).to receive(:display_players)
      allow(game).to receive(:gets).and_return("one\n")
      game.send(:start)
      expect(game).to have_received(:display_players)
    end
    
    it "asks which player would like to start the game and prints a message confirming" do
      allow(game).to receive(:gets).and_return("one\n")
      expect{ game.send(:start) }.to output(
        "\nPlayers:\n#{player1.name} - #{player1.symbol}\n#{player2.name} - #{player2.symbol}\n\n" +
        "Who would like to start?\n" +
        "#{player1.name} starts!\n"
      ).to_stdout    
    end

    it "notifies the user if input was invalid and prompts again" do
      allow(game).to receive(:gets).and_return("nobody\n", "one\n")
      expect{ game.send(:start) }.to output(
        "\nPlayers:\n#{player1.name} - #{player1.symbol}\n#{player2.name} - #{player2.symbol}\n\n" +
        "Who would like to start?\n" +
        "Invalid player name. Try again:\n" +
        "#{player1.name} starts!\n"
      ).to_stdout
    end

    it "calls #play with the correct player" do
      allow(game).to receive(:gets).and_return("two\n")
      game.send(:start)
      expect(game).to have_received(:play).with(player2)
    end
  end

  describe "#play" do

    before(:each) do
      allow(board).to receive(:display)
      allow(game).to receive(:next_turn)
      allow(game).to receive(:choose_column).and_return(3)
    end

    it "calls #display on the board" do
      game.send(:play,player1)
      expect(board).to have_received(:display)
    end

    it "calls #choose_column" do
      allow(board).to receive(:modify).and_return("success")
      game.send(:play, player1)
      expect(game).to have_received(:choose_column)
    end

    it "modifies the board" do
      allow(board).to receive(:modify).and_return("success")
      game.send(:play,player1)
      expect(board).to have_received(:modify).with(3,player1.symbol)
    end

    it "notifies the player if column is full and asks for another column until successful" do
      allow(board).to receive(:modify).and_return("fail","fail","success")
      expect{ game.send(:play, player1) }.to output(
        "That column's already full! Try another one.\n" +
        "That column's already full! Try another one.\n"
      ).to_stdout
      expect(game).to have_received(:choose_column).exactly(3).times
    end

    it "calls #next_turn with the correct player" do
      allow(board).to receive(:modify).and_return("success")
      game.send(:play,player1)
      expect(game).to have_received(:next_turn).with(player1)
    end
  end

  describe "#choose_column" do
    it "prompts for a column between 1 and 7" do
      allow(game).to receive(:gets).and_return("1\n")
      expect{ game.send(:choose_column) }.to output(
        "Please enter a column number between 1 and 7:\n"
      ).to_stdout
    end

    it "notifies the player if input was invalid and prompts again" do
      allow(game).to receive(:gets).and_return("test\n", "1\n")
      expect { game.send(:choose_column) }.to output(
        "Please enter a column number between 1 and 7:\n" +
        "That's not a number between 1 and 7. Try again:\n"
      ).to_stdout
    end

    it "returns the column index based on user input" do
      allow(game).to receive(:gets).and_return("3\n")
      expect(game.send(:choose_column)).to eql(2)
    end
  end

  describe "#next_turn" do
    it "prints a victory message with the correct player and exits the program when the board has four symbols in a row"
  end
end