class Cell

  attr_reader :name, :coordinate, :ship

  def initialize(cell_name)
    @name = cell_name
    @coordinate = cell_name
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon
    
  end

  def render

  end


end