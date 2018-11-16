require './lib/cell'

describe Cell do

  describe "#initialize" do
    it "assigns coordinates x,y and a symbol to instance variables" do
      cell = Cell.new(1,2,Player::BLACK)
      expect(cell.instance_variable_get(:@x)).to eql(1)
      expect(cell.instance_variable_get(:@y)).to eql(2)
      expect(cell.symbol).to eql(Player::BLACK)
    end
  end

  describe "#valid_coordinates?" do

    let(:cell) { Cell.new(1,2,Player::BLACK) }

    it "returns true when the given coordinates are within the cage" do
      expect(cell.send(:valid_coordinates?, 3, 4)).to be true
    end

    it "returns false when they aren't" do
      expect(cell.send(:valid_coordinates?, 7, 5)).to be false
    end
  end

  describe "#right" do
    it "returns the absolute coordinates directly to the right of the given cell in the form of an array"

    it "returns nil if there is no cell to the right of the given cell"
  end

  describe "#left" do
    it "returns the absolute coordinates directly to the left of the given cell in the form of an array"
    it "returns nil if there is no cell to the left of the given cell"
  end

  describe "#up" do
    it "returns the absolute coordinates directly above the given cell in the form of an array"
    it "returns nil if there is no cell above the given cell"
  end

  describe "#down" do
    it "returns the absolute coordinates directly below the given cell in the form of an array"

    it "returns nil if there is no cell below the given cell"
  end

  describe "#diagonal_right_up" do
    it "returns the absolute coordinates directly in the upper right direction of the given cell in the form of an array"

    it "returns nil if there is no cell there"
  end

  describe "#diagonal_right_down" do
    it "returns the absolute coordinates directly in the lower right direction of the given cell in the form of an array" 

    it "returns nil if there is no cell there"
  end

  describe "#diagonal_left_up" do
    it "returns the absolute coordinates directly in the upper left direction of the given cell in the form of an array"

    it "returns nil if there is no cell there"
  end

  describe "#diagonal_left_down" do
    it "returns the absolute coordinates directly in the lower left direction of the given cell in the form of an array"

    it "returns nil if there is no cell there"
  end

end