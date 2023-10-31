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

  #Handle user input for ship placements .gets.chomp
  
  def start_game
    #loop do 
    place_computer_ships
    place_player_ships   
    game_loop
  end

  def place_computer_ships
    @computer_ships.each do |ship|
      coordiinates = []
      until @ai_board.valid_placement?(ship, coordinates)
        row = ('A'..'D').to_a.sample
        column = (1..4).to_a.sample
        orientation = [:horizontal, :vertical].sample

        if orientation == :horizontal
          coordinates = (column..(column + ship.length - 1)).map { |column_cell| "#{row}#{column_cell}"}
        else
          coordinates = (row.ord..(row.ord + ship.length -1)).map { |row_cell| "#{row_cell.chr}#{column}"}
        end
      end
      @computer_board.place_ship(ship, coordinates)
    end
    puts "I have laid out my ships on the grid."
  end


  def place_player_ships
    puts "You now need to lay out your #{@player_ships.length} ships."
    @player_ship.each do |ship|
      puts "Place your #{ship.name}. It has a length of is #{ship.length} units:"
      coordinates = gets.chomp.split
      until @player_board.valid_placement?(ship, coordinates)
        puts "Those are invalid coordinates. Please try again:"
        coordinates = gets.chomp.split
      end
      @player_board.place_ship(ship, coordinates)
    end
  end

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
    main_menu
  end

  def display_boards
    puts "Computer's Board:"
    @computer_board.render
    puts "Player's Board:"
    @player_board.render(true)
  end

  def game_over?
    @player_ships.all?{ |ship| ship.sunk? } || @computer_ships.all?{ |ship| ship.sunk? }
  end

  def show_winner
    if @player_ships.all?{ |ship| ship.sunk? }
      puts "You sunk my battleships! You win!"
    else
      puts "I won! You suck!"
    end
  end


end



  #Main game loop 

  #Handle turn logic for both player and AI
  #Render boards
  #Check for game over conditions
  #Show game over message

