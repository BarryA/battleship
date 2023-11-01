require './lib/board.rb'
require './lib/cell.rb'
require './lib/ship.rb'
require './lib/artificial_player.rb'
require './lib/game.rb'
require 'pry'

RSpec.describe Game do
  describe "initialize" do
    it "can initialize" do
      game = Game.new

      expect(game).to be_an_instance_of(Game)
    end

    it "initializes with ships" do
      game = Game.new

      expect(game.player_ships).not_to eq([])
    end

    it "initializes with ships" do
      game = Game.new

      expect(game.computer_ships).not_to eq([])
    end
    it "initializes with ships" do
      game = Game.new

      expect(game.computer_player).to be_an_instance_of(ArtificalPlayer)
    end
  end
end