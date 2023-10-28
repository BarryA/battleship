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
end