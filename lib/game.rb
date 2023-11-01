require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/artificial_player'
require 'pry'
require 'colorize'

class Game

  attr_reader :player_board,
              :computer_board,
              :player_ships, 
              :computer_ships,
              :computer_player
              

  #Game setup (initialize players, ships, and boards)
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @computer_player = ArtificialPlayer.new(@player_board)
    @player_ships = [
      Ship.new("Battleship", 4),
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2),
      ]
    @computer_ships = [
      Ship.new("Battleship", 4),
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2),
      ]
  end
  
  def reset_game
    @player_board = Board.new
    @computer_board = Board.new
    @computer_player = ArtificialPlayer.new(@player_board)
    @player_ships = [
      Ship.new("Battleship", 4),
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2),
      ]
    @computer_ships = [
      Ship.new("Battleship", 4),
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2),
      ]
  end

  
  #main menu!
  def main_menu
    puts ""
    puts "=========== Welcome to BATTLESHIP ===========".red
    puts ""
    puts "     Enter p to play. Enter q to quit.".yellow
    puts "\n"
    input = gets.chomp

    if input == "p"
      start_game
    elsif input == "q"
      puts "=========== Thanks for playing BATTLESHIP ==========="  
      exit
    else
      puts "   I'm sorry, I did not understand. Enter p or q"
      main_menu
    end
  end

  def play_again
    puts "      Want to play again?"
    puts "Enter p to play. Enter q to quit."
    puts ""
    input = gets.chomp

    if input == "p"
      reset_game
      start_game
    elsif input == "q"
      puts "=========== Thanks for playing BATTLESHIP ===========".red  
      exit
    else
      puts "I'm sorry, I did not understand. Enter p or q"
      main_menu
    end
  end

  #Handle user input for ship placements .gets.chomp
  
  def start_game
    loop do
      display_boards
      place_computer_ships
      place_player_ships   
      game_loop
      break
    end
  end

  def place_computer_ships
    @computer_ships.each do |ship|
      coordinates = []
      until @computer_board.valid_placements?(ship, coordinates)
        row = ('A'..'E').to_a.sample
        column = (1..5).to_a.sample
        orientation = [:horizontal, :vertical].sample

        if orientation == :horizontal
          coordinates = (column..(column + ship.length - 1)).map { |column_cell| "#{row}#{column_cell}"}
        else
          coordinates = (row.ord..(row.ord + ship.length - 1)).map { |row_cell| "#{row_cell.chr}#{column}"}
        end
      end
      @computer_board.place_ship(ship, coordinates)
    end
    puts ""
    puts "I have laid out my ships on the grid."
  end

  def place_player_ships
    puts ""
    puts "You now need to lay out your #{@player_ships.length} ships."
    @player_ships.each do |ship|
      puts ""
      puts "Place your #{ship.name}. It has a length of #{ship.length} units:"
      coordinates = gets.gsub(',', '').upcase.chomp.split
      until @player_board.valid_placements?(ship, coordinates)
        puts ""
        puts "Those are invalid coordinates. Please try again:"
        coordinates = gets.gsub(',', '').upcase.chomp.split
      end
      @player_board.place_ship(ship, coordinates)
    end
  end

  #Main game loop 
  def game_loop
    loop do
      display_boards
      player_turn
      computer_turn
      
      if game_over?
        break
      end
    end
    show_winner
    play_again
  end

  def display_boards
    puts ""
    puts "Computer's Board:".red
    puts ""
    @computer_board.render(false)
    puts ""
    puts "Player's Board:".green
    puts ""
    @player_board.render(true)
  end

  def player_turn
    valid_choice = false
    coordinate = nil
    until valid_choice
      puts ""
      puts "Please enter a coordinate to fire upon"
      coordinate = gets.chomp.upcase
      if !@computer_board.valid_coordinates?(coordinate)
        puts ""
        puts "Not a valid coordinate. Please try again:"
      elsif @computer_board.cells[coordinate].fired_upon?
        puts ""
        puts "This coordinate has already been fired upon. Please try again."
      else valid_choice = true
      end
    end

    target_cell = @computer_board.cells[coordinate]
    target_cell.fire_upon

    if target_cell.empty?
      puts ""
      puts "You missed!"
      puts ""
    elsif target_cell.ship.sunk?
      puts ""
      puts "You sunk my #{target_cell.ship.name}!"
      puts ""
    else
      puts ""
      puts "It's a hit!"
      puts ""
    end
  end

  def computer_turn
    coordinate = @computer_player.select_coordinate
    target_cell = @player_board.cells[coordinate]
    target_cell.fire_upon

    if target_cell.empty?
      puts "The computer missed!"
      puts ""
    elsif target_cell.ship.sunk?
      puts "The computer sunk your #{target_cell.ship.name}!"
      puts ""
    else
      puts "The computer got a hit!"
      puts ""
    end

    hit = !target_cell.empty?
    @computer_player.previous_shots(coordinate, hit)
  end

  #Check for game over conditions
  def game_over?
    @player_ships.all?{ |ship| ship.sunk? } || @computer_ships.all?{ |ship| ship.sunk? }
  end

  #Show game over message
  def show_winner
    if @computer_ships.all?{ |ship| ship.sunk? } && @player_ships.all?{ |ship| ship.sunk? }
      puts "It's a tie!"
      puts ""
    elsif @computer_ships.all?{ |ship| ship.sunk? }
      puts "You sunk my battleships! You win!"
      puts ""
    elsif @player_ships.all?{ |ship| ship.sunk? }
      puts "I won!"
      puts ""
    else 
      puts "You're not supposed to see this... ERROR"
      puts ""
    end
  end
end


  

