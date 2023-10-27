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
    if @fired_upon == false && @ship.nil?
      
    end
  end


end