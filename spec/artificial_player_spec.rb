require './lib/artificial_player.rb'
require './lib/board.rb'
require 'pry'

describe ArtificialPlayer do
  it 'can initialize' do
    player_board = Board.new
    ai_player = ArtificialPlayer.new(player_board)

    expect(player_board).to be_an_instance_of(Board)
    expect(ai_player).to be_an_instance_of(ArtificialPlayer)
  end

  it 'has a board' do
    player_board = Board.new
    ai_player = ArtificialPlayer.new(player_board)
    chosen_coordinate = ai_player.select_coordinate

    expect(player_board.valid_coordinate?("A1")).to be true
  end


end