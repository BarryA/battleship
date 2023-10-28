require 'pry'
require './lib/cell.rb'
require './lib/ship.rb'

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
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinate_array)
    coordinate_array = []
    if coordinate_array.length < ship.length || coordinate_array.length < @ship.length
      return false
    else return true
    end
  end
end