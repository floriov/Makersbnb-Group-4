require 'space'

describe Space do
  subject(:space) { described_class.new(name: name, description: description, price: price) }
  let(:name) { '1 Space Avenue' }
  let(:description) { 'Ugly, Fear-Inducing Bungalow' }
  let(:price) { '£50.00' }

  describe '#name' do
    it 'returns the space name' do
      expect(space.name).to eq('1 Space Avenue')
    end
  end

  describe '#describe' do
    it 'returns the space description' do
      expect(space.description).to eq('Ugly, Fear-Inducing Bungalow')
    end
  end

  describe '#price' do
    it 'returns the space price' do
      expect(space.price).to eq('£50.00')
    end
  end
end