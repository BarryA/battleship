require './lib/board.rb'
require './lib/cell.rb'
require './lib/ship.rb'
require 'pry'

RSpec.describe Board do
  describe "initialize" do
    it "can initialize" do
      board = Board.new

      expect(board).to be_an_instance_of(Board)
    end

    it "initializes with cells" do
      board = Board.new

      expect(board.cells.length).to eq(16)
    end
  end

  describe "valid coordinates" do
    it "can verify valid coordinates" do
      board = Board.new

      expect(board.valid_coordinate?("A1")).to be true
      expect(board.valid_coordinate?("D4")).to be true
      expect(board.valid_coordinate?("A5")).to be false
      expect(board.valid_coordinate?("E1")).to be false
      expect(board.valid_coordinate?("A22")).to be false
    end
  end

  describe "valid placement?" do
    it "can validate placements based on length" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
    end

    it "can validate consecutive placements horizontal/vertical" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to be false
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be true
    end

    it "can validate if ship is being placed on occupied tile" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.place(cruiser, ["A1", "A2", "A3"])
      
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false
    end
  end

    
  describe "place ship" do
    it "can place a ship on the board" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.cells["A1"].ship).to eq(cruiser)
      expect(board.cells["A2"].ship).to eq(cruiser)
      expect(board.cells["A3"].ship).to eq(cruiser)
    end

    it "will not place ships on top of each other" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["A1", "B1"])

      expect(board.cells["A1"].ship).to eq(cruiser)
      expect(board.cells["A2"].ship).to eq(cruiser)
      expect(board.cells["A3"].ship).to eq(cruiser)
    end
  end
end