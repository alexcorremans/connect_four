require './lib/player'

describe Player do

  before do
    allow($stdout).to receive(:write)
  end

  describe "#initialize" do

    let(:white) { Player::WHITE }
    let(:black) { Player::BLACK }

    it "creates a first player and assigns a name and a symbol based on user input" do
      allow_any_instance_of(Player).to receive(:gets).and_return("first player\n", "black\n")
      player1 = Player.new
      expect(player1.name).to eql("First player")
      expect(player1.symbol).to eql(black)
    end

    it "creates a second player and assigns a name based on user input and the remaining symbol based on the first player's choice" do
      allow_any_instance_of(Player).to receive(:gets).and_return("second player\n")
      player2 = Player.new
      expect(player2.name).to eql("Second player")
      expect(player2.symbol).to eql(white)
    end
  end
end