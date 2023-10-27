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

  it "has a coordiante" do
    cell = Cell.new("B4")

    expect(cell.coordinate).to eq("B4")
  end
  
end