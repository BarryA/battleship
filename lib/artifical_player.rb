class ArtificialPlayer
  attr_reader :enemy_board


  # initialize with its own board, an array of previous shots, and 
  # record the last hit

  def initialize(board)
    @enemy_board = board
    @previous_shots = []
    @last_hit = nil
  end


  # need to store previous shots in an array to avoid dupliciate shots. 
  # Needs to shoot randomly at first .select ?
  # loop over the board to select a random coordinate unless it
  # is found in #previous_shots


  def previous_shot_result(coordinate, hit)
    if hit
      @last_hit = coordinate
    else
      @last_hit = nil
    end
  end


  # need to define coodinates around hits as coordinates to attack (later)
  def adjacent_coordinates(coordinate)
    row = coordinate[0].ord
    column = coordinate[1].to_i
    
  end




end