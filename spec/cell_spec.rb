require 'rspec'
require 'pry'
require './lib/cell'
require './lib/ship'

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
end
