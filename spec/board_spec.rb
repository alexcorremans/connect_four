require './lib/board'

describe Board do

#  before do
#    allow($stdout).to receive(:write)
#  end

  let(:board) { Board.new }
  let(:white) { Player::WHITE }
  let(:black) { Player::BLACK }

  describe "#initialize" do

    it "creates an empty board" do
      expect(board.cells).to eql([
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"]
      ])
    end
  end

  describe "#display" do
    it "displays the board to the command line" do
      cells = [
        ["#{white}","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["#{black}","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"]
      ]
      expected = <<-EXPECTED
 ___ ___ ___ ___ ___ ___ ___
|___|___|___|___|___|___|___|
|___|___|___|___|___|___|___|
|___|___|___|___|___|___|___|
|___|___|___|___|___|___|___|
|___|___|___|___|___|___|___|
|_#{white}_|___|___|_#{black}_|___|___|___|

EXPECTED
      expect{ board.send(:display,cells) }.to output(expected).to_stdout
    end
  end
end