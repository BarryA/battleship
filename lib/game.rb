require './lib/board'
require './lib/ship'
require './lib/cell'

class Game

  attr_reader :player_board,
              :computer_board,
              :player_ships, 
              :computer_ships
              

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_ships = [
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2)
      ]
    @computer_ships = [
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2)
      ]
  end

  def main_menu
    "Welcome to BATTLESHIP\n Enter p to play. Enter q to quit."
  end

 
  def start_game
    puts main_menu
    loop do 
      player_input = gets.chomp
      if player_input == "p" 
        computer_place_ship
        display_boards
        player_place_ship(human_cruiser)
        player_place_ship(human_submarine)
        player_shoot(coordinate)
      elsif player_input == "q"
        puts "Thanks for playing BATTLESHIP"     
      else
        puts "I'm sorry, I did not understand. Enter p or q"
      end
    end
  end

  #main menu!
  #Game setup (initialize players, ships, and boards)
  #Main game loop 
  #Handle user input for ship placements .gets.chomp
  #Handle turn logic for both player and AI
  #Render boards
  #Check for game over conditions
  #Show game over message

