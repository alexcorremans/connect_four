require './lib/game'

describe Game do

  before do
    allow($stdout).to receive(:write)
  end

  let(:white) { Player::WHITE }
  let(:black) { Player::BLACK }
  let(:cage) { Cage.new }
  let(:player1) { instance_double('Player', name: "One", symbol: black) }
  let(:player2) { instance_double('Player', name: "Two", symbol: white) }
  let(:game) { Game.new(cage, player1, player2) }

  describe "#initialize" do
    it "receives a cage and assigns it to an instance variable" do
      expect(game.instance_variable_get(:@cage)).to eql(cage)
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
      allow(cage).to receive(:display)
      allow(game).to receive(:next_turn)
      allow(game).to receive(:choose_column).and_return(3)
    end


    it "calls #display on the cage" do
      game.send(:play,player1)
      expect(cage).to have_received(:display)
    end

    it "calls #choose_column" do
      allow(cage).to receive(:modify).and_return("success")
      game.send(:play, player1)
      expect(game).to have_received(:choose_column)
    end

    it "modifies the cage" do
      allow(cage).to receive(:modify).and_return("success")
      game.send(:play,player1)
      expect(cage).to have_received(:modify).with(3,player1.symbol)
    end

    it "notifies the player if column is full and asks for another column until successful" do
      allow(cage).to receive(:modify).and_return("fail","fail","success")
      expect{ game.send(:play, player1) }.to output(
        "That column's already full! Try another one.\n" +
        "That column's already full! Try another one.\n"
      ).to_stdout
      expect(game).to have_received(:choose_column).exactly(3).times
    end

    it "calls #next_turn with the correct player" do
      allow(cage).to receive(:modify).and_return("success")
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

    before(:each) do
      allow(game).to receive(:play)
    end

    it "checks whether the player has won" do
      allow(cage).to receive(:winner?).and_return(false)
      allow(cage).to receive(:full?).and_return(false)
      game.send(:next_turn, player1)
      expect(cage).to have_received(:winner?)
    end

    it "calls #victory if the player has won" do
      allow(cage).to receive(:winner?).and_return(true)
      allow(game).to receive(:victory)
      game.send(:next_turn, player1)
      expect(game).to have_received(:victory).with(player1)
    end

    it "checks whether the cage is full" do
      allow(cage).to receive(:winner?).and_return(false)
      allow(cage).to receive(:full?).and_return(false)
      game.send(:next_turn, player1)
      expect(cage).to have_received(:full?)
    end

    it "calls #full_cage if the cage is full" do
      allow(cage).to receive(:winner?).and_return(false)
      allow(cage).to receive(:full?).and_return(true)
      allow(game).to receive(:full_cage)
      game.send(:next_turn, player1)
      expect(game).to have_received(:full_cage)
    end

    it "continues the game if there is no winner and the cage isn't full" do
      allow(cage).to receive(:winner?).and_return(false)
      allow(cage).to receive(:full?).and_return(false)
      game.send(:next_turn, player1)
      expect(game).to have_received(:play).with(player2)
    end

    it "notfies the next player that it's their turn" do
      allow(cage).to receive(:winner?).and_return(false)
      allow(cage).to receive(:full?).and_return(false)
      expect { game.send(:next_turn, player1) }.to output(
        "\nIt's your turn, #{player2.name}!\n"
      ).to_stdout
    end    
  end

  describe "#victory" do

    before(:each) do
      allow(cage).to receive(:display)
    end

    it "calls #display on the cage" do
      begin
        game.send(:victory,player1)
      rescue SystemExit
        puts "Exiting the game"
      end
      expect(cage).to have_received(:display)
    end

    it "prints a message to say the player won and ends the game" do
      begin
        expect{ game.send(:victory, player1) }.to output(
          "The winner is #{player1.name}. Congratulations!\n"
        ).to_stdout
      rescue SystemExit
        puts "Exiting the game"
      end
    end
  end

  describe "#full_cage" do

    before(:each) do
      allow(cage).to receive(:display)
    end

    it "calls #display on the cage" do
      begin
        game.send(:full_cage)
      rescue SystemExit
        puts "Exiting the game"
      end
      expect(cage).to have_received(:display)
    end

    it "prints a message to say the cage is full and ends the game" do
      begin
        expect{ game.send(:full_cage) }.to output(
          "The cage is full, and no one won. Sorry!\n"
        ).to_stdout
      rescue SystemExit
        puts "Exiting the game"
      end
    end
  end
end