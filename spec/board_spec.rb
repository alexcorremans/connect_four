require './lib/game'

describe Board do

  let(:board) { Board.new }
  let(:white) { Player::WHITE }
  let(:black) { Player::BLACK }
  let(:cells) { board.instance_variable_get(:@cells) }

  describe "#initialize" do
    it "creates an empty board" do
      expect(cells).to eql([
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
    it "displays the board on the command line" do
      board.instance_variable_set(:@cells, [
        ["#{white}","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["#{black}","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"]
      ])
      expected = <<-EXPECTED
 ___ ___ ___ ___ ___ ___ ___
|___|___|___|___|___|___|___|
|___|___|___|___|___|___|___|
|___|___|___|___|___|___|___|
|___|___|___|___|___|___|___|
|___|___|___|___|___|___|___|
|_#{white}_|___|___|_#{black}_|___|___|___|
  1   2   3   4   5   6   7

EXPECTED
      expect{ board.send(:display) }.to output(expected).to_stdout
    end
  end

  describe "#modify(column, symbol)" do
    it "modifies the correct square to the correct symbol" do
      board.instance_variable_set(:@cells, [
        ["#{white}","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"]
      ])
      board.send(:modify, 0, black)
      expect(cells[0][1]).to eql("#{black}")
    end

    it "returns success when done successfully" do
      board.instance_variable_set(:@cells, [
        ["#{white}","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"]
      ])
      expect(board.send(:modify, 0, black)).to eql("success")
    end
  
    it "returns fail when column is already full" do
      board.instance_variable_set(:@cells, [
        ["#{white}","#{black}","#{black}","#{black}","#{white}","#{black}"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"],
        ["_","_","_","_","_","_"]
      ])
      expect(board.send(:modify, 0, black)).to eql("fail")
    end
  end

  # needs a four_in_a_row? and a full? method that Game can call
end