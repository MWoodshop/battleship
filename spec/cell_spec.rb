require 'rspec'
require 'pry'
require './lib/cell'
require './lib/ship'

# !!! We need to add a test if an invalid cell is given in the future.!!!

RSpec.describe Cell do
  describe '#initialize' do
    it 'exists' do
      cell = Cell.new('B4')
    end
    it 'returns correct value' do
      cell = Cell.new('B4')

      expect(cell.coordinate).to eq('B4')
    end
    it 'returns nil' do
      cell = Cell.new('B4')

      expect(cell.ship).to eq(nil)
    end
  end

  describe 'empty?' do
    it 'returns true' do
      cell = Cell.new('B4')

      expect(cell.empty?).to eq(true)
    end
  end

  describe 'place_ship' do
    it 'returns ship' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)
      cell.place_ship(cruiser)

      expect(cell.ship).to eq(cruiser)
    end
    it 'returns false' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)
      cell.place_ship(cruiser)

      expect(cell.empty?).to eq(false)
    end
  end

  describe 'fire_upon' do
    it 'fired_upon starts false' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to eq(false)
    end

    it 'fired_upon is true' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)
      cell.place_ship(cruiser)
      cell.fire_upon

      expect(cell.fired_upon?).to eq(true)
    end

    it 'decreases health' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)
      cell.place_ship(cruiser)
      cell.fire_upon

      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to eq(true)
    end

    it 'misses' do
      b4 = Cell.new('B4')
      d2 = Cell.new('D2')
      cruiser = Ship.new('Cruiser', 3)
      b4.place_ship(cruiser)
      d2.fire_upon

      expect(d2.fired_upon?).to eq(true)
      expect(d2.ship).to eq(nil)
      expect(d2.empty?).to eq(true)
      expect(b4.ship.health).to eq(3)
    end
  end

  describe 'render' do
    it 'returns . by default' do
      cell_1 = Cell.new('B4')
      cell_1.render

      expect(cell_1.render).to eq('.')
    end

    it 'returns M' do
      cell_1 = Cell.new('B4')
      cell_1.fire_upon

      expect(cell_1.render).to eq('M')
    end

    it 'returns . on second cell' do
      cell_1 = Cell.new('B4')
      cell_1.fire_upon
      cell_2 = Cell.new('C3')
      cruiser = Ship.new('Cruiser', 3)
      cell_2.place_ship(cruiser)

      expect(cell_2.render).to eq('.')
    end

    it 'returns S' do
      cell_1 = Cell.new('B4')
      cell_1.fire_upon
      cell_2 = Cell.new('C3')
      cruiser = Ship.new('Cruiser', 3)
      cell_2.place_ship(cruiser)

      expect(cell_2.render(true)).to eq('S')
    end

    it 'returns H' do
      cell_1 = Cell.new('B4')
      cell_1.fire_upon
      cell_2 = Cell.new('C3')
      cruiser = Ship.new('Cruiser', 3)
      cell_2.place_ship(cruiser)
      cell_2.fire_upon

      expect(cell_2.render).to eq('H')
    end

    it 'returns sunk? = true' do
      cell_1 = Cell.new('B4')
      cell_1.fire_upon
      cell_2 = Cell.new('C3')
      cruiser = Ship.new('Cruiser', 3)
      cell_2.place_ship(cruiser)
      cell_2.fire_upon

      expect(cruiser.sunk?).to eq(false)

      cruiser.hit
      cruiser.hit

      expect(cruiser.sunk?).to eq(true)
    end

    it 'returns X' do
      cell_1 = Cell.new('B4')
      cell_1.fire_upon
      cell_2 = Cell.new('C3')
      cruiser = Ship.new('Cruiser', 3)
      cell_2.place_ship(cruiser)
      cell_2.fire_upon
      cruiser.hit
      cruiser.hit

      expect(cell_2.render).to eq('X')
    end
  end
end
