require 'pry'
require './lib/ship'
require 'colorize'

class Cell

  attr_reader :name, :coordinate, :ship, :fired_upon
  attr_accessor :render, :empty

  def initialize(cell_name)
    @name = cell_name
    @coordinate = cell_name
    @ship = nil
    @fired_upon = false
    @render = "."
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @fired_upon = true
    if empty? == false
      @ship.hit
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(fog_of_war = false)
    if fired_upon == true && empty? == true
      @render = "M".blue
    elsif fired_upon == true && empty? == false && @ship.sunk? == false
      @render = "H".yellow
    elsif fired_upon == true && empty? == false && @ship.sunk? == true
      @render = "X".red
    elsif fog_of_war == true && empty? == false
      @render = "S"
    else @render
    end
  end


end