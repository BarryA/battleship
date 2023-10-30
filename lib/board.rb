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
  
    # checks if there is a cell key that is the same as given coordinate
  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    # check if ship length is same as coordinates length
    return false unless coordinates.length == ship.length
    # return false if no coordinates provided
    return false if coordinates.empty?
    # return false if coordinates are occupied.
    if coordinates.any? { |coordinate| !@cells[coordinate].empty?}
      return false
    end

    # iterates over coodinates and separates into rows and columns. Separates coordinates into two parts and 
    # assigns ASCII values to the letters. This is necessary for the next part to verify if the ASCII value
    # numbers are consecutive.
    rows = coordinates.map { |coordinate| coordinate[0].ord }
    columns = coordinates.map { |coordinate| coordinate[1].to_i }

    # row.uniq.length removes potential duplicate values and checks if in the same row ["A1", "A2", "A3"]
    # would return [65, 65, 65] => .uniq makes it [65] while ["A1", "B1", "C1"] would return [65, 66, 67]
    # If it returns with an array length of 1, it is in the same row. 
    # columns == (columns.min..columns.max).to_a creates a range from the columns array. "to_a" is needed
    # to convert the range into an array to compare against the columns array in the .map function above. 
    # if there is a gap or the numbers are in the wrong order it will return false. 

    horizontal_consecutive = (rows.uniq.length == 1) && (columns == (columns.min..columns.max).to_a)
    vertical_consecutive = (columns.uniq.length == 1) && (rows == (rows.min..rows.max).to_a)

    #if neither horizontal or vertical checks are true, method is implicitly true, otherwise false
    horizontal_consecutive || vertical_consecutive
  end

    # seperates out coordinates and utilizes the .place_ship method from cell class
    # to occupy the cell with a ship. Stole "coordinates.any" method from above to
    # validate if cells are occupied.
  def place(ship, coordinates)
    if coordinates.any? { |coordinate| !@cells[coordinate].empty?}
      return "Please select coordinates that do not overlap."
    end

    # calls .place_ship method on given coordinate to populate ship object inside of the cell
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def render(fog_of_war = true)





    # I want the result to be 
    #"  1 2 3 4 \n
    # A . . . . \n
    # B . . . . \n
    # C . . . . \n
    # D . . . . \n"
    
    # Each dot has to be linked to a coordinate @cells[coordinate].render(fog_of_war(t/f))
    # Maybe seperate out rows from the header since it contains no cells
    # .each?

  end
end