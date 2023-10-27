require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  
  describe "initialize" do
    it "can initialize" do
      cell = Cell.new("B4")
      expect(cell).to be_an_instance_of(Cell)
    end

    it "has a name" do
      cell = Cell.new("B4")
      expect(cell.name).to eq("B4")
    end

    it "has a coordinate" do
      cell = Cell new("B4")
      expect(cell.coordinate).to eq("B4")
    end

    it "initializes empty" do
      cell = Cell.new("B4")
      expect(cell.empty?).to be true
    end

    it 'creates a cell with a "."' do
      cell = Cell.new("B4")
      expect(cell.render).to eq(".")
    end
  end

  describe "#place_ship" do
    it "places a ship in the cell" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.ship).to eq(cruiser)
    end

    it "returns false for a cell with a ship" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.empty?).to be false
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

    describe "render" do
      it 'updates the cell status to "M" after firing upon' do
        cell = Cell.new("B4")
        cell.fire_upon
        expect(cell.render).to eq("M")
      end

      it 'creates a cell with "S" when ship is present' do
        cell = Cell.new("C3")
        cruiser = Ship.new("Cruiser", 3)
        cell.place_ship(cruiser)
        expect(cell.render(true)).to eq("S")
      end

      it 'updates the cell to "H" after firing upon' do
        cell = Cell.new("C3")
        cruiser = Ship.new("Cruiser", 3)
        cell.place_ship(cruiser)
        cell.fire_upon
        expect(cell.render).to eq("H")
      end

      it 'updates the cell to "X" after the ship is sunk' do
        cell = Cell.new("C3")
        cruiser = Ship.new("Cruiser", 3)
        cell.place_ship(cruiser)
        cruiser.hit
        cruiser.hit
        expect(cell.render).to eq("X")
      end
    end
  end
end