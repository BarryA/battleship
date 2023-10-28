require './lib/board.rb'
require './lib/cell.rb'
require './lib/ship.rb'
require 'pry'

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