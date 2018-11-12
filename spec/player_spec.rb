require './lib/player'

describe Player do

  before do
    allow($stdout).to receive(:write)
  end

  describe "#initialize" do

    let(:white) { Player::WHITE }
    let(:black) { Player::BLACK }

    context "when creating first player" do

      it "creates a first player and asks for user input in order ot assign name and symbol" do
        allow_any_instance_of(Player).to receive(:gets).and_return("one\n", "black\n")
        expect{ player1 = Player.new }.to output(
          "Enter first player name:\n" +
          "Would you like to play black or white?\n"
        ).to_stdout
      end

      it "notifies the player and prompts again if no name was entered" do
        allow_any_instance_of(Player).to receive(:gets).and_return("\n", "one\n", "black\n")
        expect{ player1 = Player.new }.to output(
          "Enter first player name:\n" +
          "You didn't enter a name. Try again:\n" +
          "Would you like to play black or white?\n"
        ).to_stdout        
      end

      it "notifies the player and prompts again if invalid symbol input was entered" do
        allow_any_instance_of(Player).to receive(:gets).and_return("one\n", "yellow\n", "black\n")
        expect{ player1 = Player.new }.to output(
          "Enter first player name:\n" +
          "Would you like to play black or white?\n" +
          "Please choose black or white.\n"
        ).to_stdout
      end

      it "assigns a name based on user input" do
        allow_any_instance_of(Player).to receive(:gets).and_return("one\n", "black\n")
        player1 = Player.new
        expect(player1.name).to eql("One")
      end


      it "assigns a symbol based on user input" do
        allow_any_instance_of(Player).to receive(:gets).and_return("one\n", "black\n")
        player1 = Player.new
        expect(player1.symbol).to eql(black)
      end 
    end

    context "when creating second player" do

      it "creates a second player and asks for user input in order to assign name and symbol" do
        allow_any_instance_of(Player).to receive(:gets).and_return("two\n")
        player1 = instance_double('Player', name: "One", symbol: black)
        expect{ player2 = Player.new(player1) }.to output(
          "Enter second player name:\n"
        ).to_stdout
      end

      it "notifies the player and prompts again if input is the same as first player's name" do
        allow_any_instance_of(Player).to receive(:gets).and_return("one\n", "two\n")
        player1 = instance_double('Player', name: "One", symbol: black)
        expect{ player2 = Player.new(player1) }.to output(
          "Enter second player name:\n" +
          "You didn't enter a name, or that name is already taken. Try again:\n"
        ).to_stdout
      end

      it "assigns the remaining symbol based on first player's choice" do
        player1 = instance_double('Player', name: "One", symbol: black)
        allow_any_instance_of(Player).to receive(:gets).and_return("two\n")
        player2 = Player.new(player1)
        expect(player2.symbol).to eql(white)
      end
    end
  end
end