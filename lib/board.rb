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

  def valid_coordinates?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_placements?(ship, coordinates)
    # Length check
    unless coordinates.length == ship.length
      return false
    end
    
    # Empty check
    if coordinates.empty?
      return false
    end
    
    # Existence and emptiness check
    if coordinates.any? { |coordinate| !@cells.key?(coordinate) || !@cells[coordinate].empty? }
      return false
    end
    
    # Rows and columns
    rows = coordinates.map { |coordinate| coordinate[0].ord }
    columns = coordinates.map { |coordinate| coordinate[1].to_i }
  
    # Horizontal check
    horizontal_consecutive = (rows.uniq.length == 1) && (columns == (columns.min..columns.max).to_a)
    if horizontal_consecutive
      return true
    end
  
    # Vertical check
    vertical_consecutive = (columns.uniq.length == 1) && (rows == (rows.min..rows.max).to_a)
    if vertical_consecutive
      return true
    end
    false
  end

  def place_ship(ship, coordinates)
    if coordinates.any? { |coordinate| !@cells.key?(coordinate) || !@cells[coordinate].empty? }
      return "Please select coordinates that do not overlap."
    end

    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def render(fog_of_war = false)
    board_result = "  1 2 3 4 \n"

    ('A'..'D').each do |row|
      row_string = "#{row} "
      (1..4).each do |column|
        cell_key = "#{row}#{column}"
        row_string += "#{@cells[cell_key].render(fog_of_war)} "
      end
      board_result += row_string.strip + " \n"
    end
    puts board_result
    board_result
  end
end