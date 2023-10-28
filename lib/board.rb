require 'pry'
require './lib/cell.rb'
class Board

  attr_reader :cells

  def initialize
    @cells = {}
    create_cells
  end

  def create_cells
    ('A'..'D').each do |row|
      (1..4).each do |column|
        cell_key = "#{row}#{column}"
        @cells[cell_key] = Cell.new("#{row}#{column}")
      end
    end
  end

  def valid_coordinate?(coordinate)
    valid_cell_keys = {
      "A1" => true, "A2" => true, "A3" => true, "A4" => true,
      "B1" => true, "B2" => true, "B3" => true, "B4" => true,
      "C1" => true, "C2" => true, "C3" => true, "C4"=> true,
      "D1" => true, "D2" => true, "D3"=> true, "D4"=> true
    }
    valid_cell_keys.key?(coordinate)
  end

  def valid_placement?

  end
end