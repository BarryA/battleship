class Ship
  attr_reader :name, :length, :health

  def initialize(ship_name, length)
    @name = ship_name
    @length = length
    @health = length
    @sunk = nil
  end

  def sunk?
    if @health.zero?
      @sunk = true
    end
    @health.zero?
  end

  def hit
    @health -= 1
  end
end