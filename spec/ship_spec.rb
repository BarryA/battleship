require './lib/ship'
require 'pry'

RSpec.describe Ship do
  
  it "can initialize" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_an_instance_of(Ship)
  end

  it "has a name" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq("Cruiser")
  end

  it "has a given length" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.length).to eq(3)
  end

  it "has health" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.health).to eq(3)
  end

  it "hasn't sunk yet" do
    cruiser = Ship.new("Cruiser", 3)
  
    expect(cruiser.sunk?).to be false
  end

  it "can be hit" do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit

    expect(cruiser.health).to eq(2)
  end

  it "can be sunk" do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    cruiser.hit
    cruiser.hit

    expect(cruiser.health).to eq(0)
    expect(cruiser.sunk?).to be true
  end
end