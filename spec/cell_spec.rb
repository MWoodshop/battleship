require 'rspec'
require './lib/cell'

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
end
