require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/artificial_player'
require 'pry'
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

  def play_again
    puts "Want to play again?"
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
        row = ('A'..'D').to_a.sample
        column = (1..4).to_a.sample
        orientation = [:horizontal, :vertical].sample

        if orientation == :horizontal
          coordinates = (column..(column + ship.length - 1)).map { |column_cell| "#{row}#{column_cell}"}
        else
          coordinates = (row.ord..(row.ord + ship.length - 1)).map { |row_cell| "#{row_cell.chr}#{column}"}
        end
      end
      @computer_board.place_ship(ship, coordinates)
    end
    puts "\n"
    puts "I have laid out my ships on the grid."
  end

  def place_player_ships
    puts "You now need to lay out your #{@player_ships.length} ships."
    @player_ships.each do |ship|
      puts "Place your #{ship.name}. It has a length of #{ship.length} units:"
      coordinates = gets.gsub(',', '').upcase.chomp.split
      until @player_board.valid_placements?(ship, coordinates)
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
    puts "\n"
    puts "Computer's Board:"
    puts "\n"
    @computer_board.render(false)
    puts "\n"
    puts "Player's Board:"
    puts "\n"
    @player_board.render(true)
  end

  def player_turn
    valid_choice = false
    coordinate = nil
    until valid_choice
      puts "\n"
      puts "Please enter a coordinate to fire upon"
      coordinate = gets.chomp.upcase
      if !@computer_board.valid_coordinates?(coordinate)
        puts "\n"
        puts "Not a valid coordinate. Please try again:"
      elsif @computer_board.cells[coordinate].fired_upon?
        puts "\n"
        puts "This coordinate has already been fired upon. Please try again."
      else valid_choice = true
      end
    end

    target_cell = @computer_board.cells[coordinate]
    target_cell.fire_upon

    if target_cell.empty?
      puts "You missed!"
      puts "\n"
    elsif target_cell.ship.sunk?
      puts "You sunk my #{target_cell.ship.name}!"
      puts "\n"
    else
      puts "It's a hit!"
      puts "\n"
    end
  end

  def computer_turn
    coordinate = @computer_player.select_coordinate
    target_cell = @player_board.cells[coordinate]
    target_cell.fire_upon

    if target_cell.empty?
      puts "The computer missed!"
      puts "\n"
    elsif target_cell.ship.sunk?
      puts "The computer sunk your #{target_cell.ship.name}!"
      puts "\n"
    else
      puts "The computer got a hit!"
      puts "\n"
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
    if @player_ships.all?{ |ship| ship.sunk? }
      puts "You sunk my battleships! You win!"
      puts "\n"
    elsif @computer_ships.all?{ |ship| ship.sunk? }
      puts "I won! You suck!"
      puts "\n"
    else 
      puts "You're not supposed to see this... ERROR"
      puts "\n"
    end
  end


end


  

