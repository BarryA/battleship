require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class ArtificialPlayer
  
  attr_reader :player_board

  def initialize(board)
    @player_board = board
    @previous_shots = []
    @last_hit = nil
  end

  def select_coordinate
    if @last_hit
      possible_coordinates = adjacent_coordinates(@last_hit)
      target = possible_coordinates.find { |coordinate| !@previous_shots.include?(coordinate) && @player_board.valid_coordinates?(coordinate) }
      return target if target
    end

    loop do
      row = ('A'..'D').to_a.sample
      column = (1..4).to_a.sample
      coordinate = "#{row}#{column}"
      unless @previous_shots.include?(coordinate)
        return coordinate
      end
    end
  end


  def previous_shots(coordinate, hit)
    @previous_shots << coordinate
    if hit
      @last_hit = coordinate
    else
      @last_hit = nil
    end
  end

  def adjacent_coordinates(coordinate)
    row = coordinate[0]
    column = coordinate[1].to_i
    targeted_coordinates = [
      "#{row}#{column - 1}", "#{row}#{column + 1}",
      "#{(row.ord - 1).chr}#{column}", "#{(row.ord + 1).chr}#{column}"
    ]
    targeted_coordinates.select { |coordinate| @player_board.valid_coordinates?(coordinate) }
  end
end