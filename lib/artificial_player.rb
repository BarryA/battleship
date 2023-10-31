require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class ArtificialPlayer
  
  attr_reader :enemy_player_board

  # initialize with its own board, an array of previous shots, and 
  # record the last hit

  def initialize(board)
    @enemy_player_board = board
    @previous_shots = []
    @last_hit = nil
  end

  #if last target was a hit, utilize targeted_coordinates
  def select_coordinate
    if @last_hit
      possible_coordinates = adjacent_coordinates(@last_hit)
      # target possible coordinates that are not included in previous shots
      # and a valid coordinate
      # .find? to find first coordinate that matches conditions of "not in previous shots" and "valid"
      target = possible_coordinates.find { |coordinate| !@previous_shots.include?(coordinate) && @enemy_board.valid_coordinate?(coordinate)}
      return target if target
    end

    # need to store previous shots in an array to avoid dupliciate shots. 
    # Needs to shoot randomly at first .select ?  

    loop do
      row = ('A'..'D').to_a.sample
      column = (1..4).to_a.sample
      coordinate = "#{row}#{column}"
    # loop over the board to select a random coordinate unless it
    # is found in #previous_shots
      unless 
        @previous_shots.include?(coordinate)
        return coordinate
      end
    end
  end


  def previous_shot_result(coordinate, hit)
    if hit
      @last_hit = coordinate
    else
      @last_hit = nil
    end
  end


  # need to define coodinates around hits as coordinates to attack (later)
  def adjacent_coordinates(coordinate)
    row = coordinate[0]
    column = coordinate[1].to_i

    targeted_coordinates = [
      "#{row}#{column - 1}", "#{row}#{column + 1}",
      "#{(row.ord - 1).chr}#{column}", "#{(row.ord + 1).chr}#{column}"
    ]

    # need to ensure that the coordinate is valid and not already targeted.
    targeted_coordinates.select { |coordinate| @enemy_board.valid_coordinate?(coordinate) }
  end




end