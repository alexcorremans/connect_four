require './lib/cage'

describe Cage do

  let(:cage) { Cage.new }
  let(:cells) { cage.instance_variable_get(:@cells) }
  let(:white) { Player::WHITE }
  let(:black) { Player::BLACK }

  describe "#initialize" do
    it "creates an empty cage" do
      expect(cells).to eql([[],[],[],[],[],[],[]])
    end
  end

  describe "#display" do
    it "displays the cage on the command line" do
      cage.instance_variable_set(:@cells, [
        [Cell.new(0,0,white)],
        [],
        [],
        [Cell.new(3,0,black)],
        [],
        [],
        []
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
      expect{ cage.send(:display) }.to output(expected).to_stdout
    end
  end

  describe "#modify(column, symbol)" do
    it "modifies the correct square to the correct symbol" do
      cage.instance_variable_set(:@cells, [
        [Cell.new(0,0,white)],[],[],[],[],[],[]
      ])
      cage.send(:modify, 0, black)
      expect(cells[0][1]).to be_a Cell
      expect(cells[0][1].instance_variable_get(:@x)).to eql(0)
      expect(cells[0][1].instance_variable_get(:@y)).to eql(1)
      expect(cells[0][1].instance_variable_get(:@symbol)).to eql(black)
    end

    it "returns success when done successfully" do
      cage.instance_variable_set(:@cells, [
        [Cell.new(0,0,white)],[],[],[],[],[],[]
      ])
      expect(cage.send(:modify, 0, black)).to eql("success")
    end
  
    it "returns fail when column is already full" do
      cage.instance_variable_set(:@cells, [
        [Cell.new(0,0,white),Cell.new(0,1,black),Cell.new(0,2,black),Cell.new(0,3,black),Cell.new(0,4,white),Cell.new(0,5,black)],
        [],
        [],
        [],
        [],
        [],
        []
      ])
      expect(cage.send(:modify, 0, black)).to eql("fail")
    end
  end

  describe "check" do
    it "returns false if there is no cell in the given direction"

    it "returns false if the cell in the given direction is empty"

    it "returns false if the cell in the given direction contains a different symbol"

    it "returns true if there are four identical symbols in a row"
  end

  describe "#winner?" do
    it "returns true when there are four identical symbols in a row" do
      cage.instance_variable_set(:@cells, [
        [Cell.new(0,0,white)],
        [Cell.new(1,0,white)],
        [Cell.new(2,0,white)],
        [Cell.new(3,0,white)],
        [],
        [],
        []
      ])
      expect(cage.send(:winner?, white)).to be true
    end

    it "returns true when there are four identical symbols in a column" do
      cage.instance_variable_set(:@cells, [
        [Cell.new(0,0,black),Cell.new(0,1,black),Cell.new(0,2,black),Cell.new(0,3,black)],
        [],
        [],
        [],
        [],
        [],
        []
      ])
      expect(cage.send(:winner?, black)).to be true
    end

    it "returns true when there are four identical symbols diagonally" do
      cage.instance_variable_set(:@cells, [
        [Cell.new(0,0,white)],
        [Cell.new(1,0,black),Cell.new(1,1,white)],
        [Cell.new(2,0,black),Cell.new(2,1,black),Cell.new(2,2,white)],
        [Cell.new(3,0,white),Cell.new(3,1,black),Cell.new(3,2,black),Cell.new(3,3,white)],
        [Cell.new(4,0,white)],
        [],
        []
      ])
      expect(cage.send(:winner?, white)).to be true
    end

    it "returns false in any other case" do
      cage.instance_variable_set(:@cells, [
        [Cell.new(0,0,white)],
        [Cell.new(1,0,white)],
        [Cell.new(2,0,black)],
        [Cell.new(3,0,black)],
        [],
        [],
        []
      ])
    end
  end

  describe "#full?" do
    it "returns true when the board is full" do
      cage.instance_variable_set(:@cells, [
        [Cell.new(0,0,white),Cell.new(0,1,black),Cell.new(0,2,black),Cell.new(0,3,black),Cell.new(0,4,white),Cell.new(0,5,white)],
        [Cell.new(1,0,white),Cell.new(1,1,white),Cell.new(1,2,white),Cell.new(1,3,white),Cell.new(1,4,black),Cell.new(1,5,black)],
        [Cell.new(2,0,white),Cell.new(2,1,black),Cell.new(2,2,black),Cell.new(2,3,white),Cell.new(2,4,black),Cell.new(2,5,white)],
        [Cell.new(3,0,black),Cell.new(3,1,white),Cell.new(3,2,white),Cell.new(3,3,white),Cell.new(3,4,black),Cell.new(3,5,white)],
        [Cell.new(4,0,black),Cell.new(4,1,white),Cell.new(4,2,black),Cell.new(4,3,black),Cell.new(4,4,white),Cell.new(4,5,black)],
        [Cell.new(5,0,black),Cell.new(5,1,black),Cell.new(5,2,white),Cell.new(5,3,black),Cell.new(5,4,black),Cell.new(5,5,white)],
        [Cell.new(6,0,white),Cell.new(6,1,white),Cell.new(6,2,black),Cell.new(6,3,white),Cell.new(6,4,white),Cell.new(6,5,black)]
      ])
      expect(cage.send(:full?)).to be true
    end

    it "returns false when it isn't" do
      cage.instance_variable_set(:@cells, [
        [Cell.new(0,0,white),Cell.new(0,1,black),Cell.new(0,2,black),Cell.new(0,3,black),Cell.new(0,4,white),Cell.new(0,5,white)],
        [Cell.new(1,0,white),Cell.new(1,1,white),Cell.new(1,2,white),Cell.new(1,3,white),Cell.new(1,4,black),Cell.new(1,5,black)],
        [Cell.new(2,0,white),Cell.new(2,1,black),Cell.new(2,2,black),Cell.new(2,3,white),Cell.new(2,4,black),Cell.new(2,5,white)],
        [Cell.new(3,0,black),Cell.new(3,1,white),Cell.new(3,2,white),Cell.new(3,3,white),Cell.new(3,4,black),Cell.new(3,5,white)],
        [Cell.new(4,0,black),Cell.new(4,1,white),Cell.new(4,2,black),Cell.new(4,3,black),Cell.new(4,4,white),Cell.new(4,5,black)],
        [Cell.new(5,0,black),Cell.new(5,1,black),Cell.new(5,2,white),Cell.new(5,3,black),Cell.new(5,4,black),Cell.new(5,5,white)],
        [Cell.new(6,0,white),Cell.new(6,1,white),Cell.new(6,2,black),Cell.new(6,3,white),Cell.new(6,4,white)]
      ])
      expect(cage.send(:full?)).to be false

    end
  end
end