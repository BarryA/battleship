require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  
  it "can initialize" do
    cell = Cell.new("B4")

    expect(cell).to be_an_instance_of(Cell)
  end

  it "has a name" do
    cell = Cell.new("B4")

    expect(cell.name).to eq("B4")
  end

  it "has a coordinate" do
    cell = Cell.new("B4")

    expect(cell.coordinate).to eq("B4")
  end
  
  describe "#empty?" do
    it "returns true for an empty cell" do
      cell = Cell.new("B4")
      
      expect(cell.empty?).to be true
    end
  end

  it "returns false for a cell with a ship" do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    
    expect(cell.empty?).to be false
  end
end

describe "#place_ship" do
  it "places a ship in the cell" do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    
    expect(cell.ship).to eq(cruiser)
  end
end

describe "#fired_upon?" do
  it "returns false when a cell has not been fired upon" do
    cell = Cell.new("B4")
    
    expect(cell.fired_upon?).to be false
  end

  it "returns true when a cell has been fired upon" do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    
    expect(cell.fired_upon?).to be true
  end
end

describe "#fire_upon" do
  it "damages the ship in the cell" do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    
    expect(cell.ship.health).to eq(2)
  end

end