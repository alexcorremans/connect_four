require './lib/cell'

describe Cell do

  let(:white) { Player::WHITE }
  let(:black) { Player::BLACK }

  describe "#initialize" do
    it "assigns coordinates x,y and a symbol to instance variables" do
      cell = Cell.new(1,2,black)
      expect(cell.instance_variable_get(:@x)).to eql(1)
      expect(cell.instance_variable_get(:@y)).to eql(2)
      expect(cell.symbol).to eql(black)
    end
  end

  describe "#valid_coordinates?" do

    let(:cell) { Cell.new(1,2,black) }

    it "returns true when the given coordinates are within the cage" do
      expect(cell.send(:valid_coordinates?, 3, 4)).to be true
    end

    it "returns false when they aren't" do
      expect(cell.send(:valid_coordinates?, 7, 5)).to be false
    end
  end

  describe "#right" do
    it "returns the absolute coordinates directly to the right of the given cell in the form of an array" do
      cell = Cell.new(0,0,white)
      expect(cell.send(:right)).to eql([1,0])
    end

    it "returns nil if there is no cell to the right of the given cell" do
      cell = Cell.new(6,0,white)
      expect(cell.send(:right)).to be nil
    end
  end

  describe "#left" do
    it "returns the absolute coordinates directly to the left of the given cell in the form of an array" do
      cell = Cell.new(6,0,black)
      expect(cell.send(:left)).to eql([5,0])
    end

    it "returns nil if there is no cell to the left of the given cell" do
      cell = Cell.new(0,0,black)
      expect(cell.send(:left)).to be nil
    end
  end

  describe "#up" do
    it "returns the absolute coordinates directly above the given cell in the form of an array" do
      cell = Cell.new(0,0,black)
      expect(cell.send(:up)).to eql([0,1])
    end

    it "returns nil if there is no cell above the given cell" do
      cell = Cell.new(0,5,black)
      expect(cell.send(:up)).to be nil
    end    
  end

  describe "#down" do
    it "returns the absolute coordinates directly below the given cell in the form of an array" do
      cell = Cell.new(0,5,white)
      expect(cell.send(:down)).to eql([0,4])
    end

    it "returns nil if there is no cell below the given cell" do
      cell = Cell.new(0,0,white)
      expect(cell.send(:down)).to be nil
    end
  end

  describe "#diagonal_right_up" do
    it "returns the absolute coordinates directly in the upper right direction of the given cell in the form of an array" do
      cell = Cell.new(0,0,white)
      expect(cell.send(:diagonal_right_up)).to eql([1,1])
    end

    it "returns nil if there is no cell there" do
      cell = Cell.new(5,5,white)
      expect(cell.send(:diagonal_right_up)).to be nil
    end
  end

  describe "#diagonal_right_down" do
    it "returns the absolute coordinates directly in the lower right direction of the given cell in the form of an array" do
      cell = Cell.new(0,5,black)
      expect(cell.send(:diagonal_right_down)).to eql([1,4])
    end

    it "returns nil if there is no cell there" do
      cell = Cell.new(3,0,black)
      expect(cell.send(:diagonal_right_down)).to be nil
    end
  end

  describe "#diagonal_left_up" do
    it "returns the absolute coordinates directly in the upper left direction of the given cell in the form of an array" do
      cell = Cell.new(1,0,white)
      expect(cell.send(:diagonal_left_up)).to eql([0,1])
    end

    it "returns nil if there is no cell there" do
      cell = Cell.new(1,5,white)
      expect(cell.send(:diagonal_left_up)).to be nil
    end
  end

  describe "#diagonal_left_down" do
    it "returns the absolute coordinates directly in the lower left direction of the given cell in the form of an array" do
      cell = Cell.new(4,3,black)
      expect(cell.send(:diagonal_left_down)).to eql([3,2])
    end

    it "returns nil if there is no cell there" do
      cell = Cell.new(4,0,black)
      expect(cell.send(:diagonal_left_down)).to be nil
    end
  end
end