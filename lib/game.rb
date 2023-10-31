require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/artificial_player'

class Game

  attr_reader :player_board,
              :computer_board,
              :player_ships, 
              :computer_ships
              

  #Game setup (initialize players, ships, and boards)
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @computer = ArtificialPlayer.new(@player_board)
    @player_ships = [
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2)
      ]
    @computer_ships = [
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2)
      ]
  end
  
  #main menu!
  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp

    if input == "p"
      start_game
    elsif input == "q"
      puts "Thanks for playing BATTLESHIP"  
      exit
    else
      puts "I'm sorry, I did not understand. Enter p or q"
      main_menu
    end
  end

 
  def start_game
    loop do 
        computer_place_ship
        display_boards
        player_place_ship(human_cruiser)
        player_place_ship(human_submarine)
        player_shoot(coordinate)
    end
  end
end



  #Main game loop 
  #Handle user input for ship placements .gets.chomp
  #Handle turn logic for both player and AI
  #Render boards
  #Check for game over conditions
  #Show game over message

