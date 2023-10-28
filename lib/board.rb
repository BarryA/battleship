require 'pry'
require './lib/cell.rb'
class Board

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

  end

  def valid_placement?

  end
end