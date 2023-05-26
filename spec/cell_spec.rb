require 'rspec'
require './lib/cell'

RSpec.describe Cell do
  describe '#initialize' do
    it 'exists' do
      cell = Cell.new
    end
  end
end
