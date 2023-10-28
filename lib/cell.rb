class Cell

  attr_reader :name, :coordinate, :ship, :fired_upon

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
    if !empty?
      @ship.hit
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render
    if fired_upon == false && empty? == false
      @render = "S"
    elsif fired_upon == true && empty? == true
      @render = "M"
    elsif fired_upon == true && empty? == false && @ship.sunk? == false
      @render = "H"
    elsif fired_upon == true && empty? == false && @ship.sunk? == true
      @render = "X"
    else @render
    end
  end



end