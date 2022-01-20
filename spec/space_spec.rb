# frozen_string_literal: true

require 'space'
require 'pg'
require_relative 'database_helpers'

describe Space do
  subject(:space) { described_class.new(id: id, name: name, description: description, price: price, available_from: available_from, available_to: available_to,  user_id: user_id) }
  let(:id) { 1 }
  let(:name) { '1 Space Avenue' }
  let(:description) { 'Ugly, Fear-Inducing Bungalow' }
  let(:price) { '50.00' }
  let(:available_from) { '01/02/2022' }
  let(:available_to) { '04/02/2022' }
  let(:user_id) { 1 }

  describe '#id' do
    it 'returns the space id' do
      expect(space.id).to eq(1)
    end
  end

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
      expect(space.price).to eq('50.00')
    end
  end

  describe '#available_from' do
    it 'returns the start date' do
      expect(space.available_from).to eq('01/02/2022')
    end
  end

  describe '#available_to' do
    it 'returns the available_to' do
      expect(space.available_to).to eq('04/02/2022')
    end
  end

  describe '.all' do
    it 'returns a list of spaces' do
      DatabaseConnection.query('INSERT INTO users (id) VALUES ($1)', [1])

      Space.add(name: 'New space', 
        description: 'Hilarious fun description', 
        price: '22.34', 
        available_from: '01/02/2022', 
        available_to: '04/02/2022', 
        user_id: 1)

      spaces = Space.all

      expect(spaces.first.id.to_i).to be_a Integer
      expect(spaces.size).to eq 1
      expect(spaces.first).to be_a Space
      expect(spaces.first.description).to eq 'Hilarious fun description'
      expect(spaces.last.user_id).to eq '1'
    end
  end

  describe '.add' do
    it 'adds a space' do
      DatabaseConnection.query('INSERT INTO users (id) VALUES ($1)', [1])
      
      space = Space.add(name: 'Newer space', description: 'Boring description', price: '22.34', available_from: '01/02/2022', available_to: '04/02/2022', user_id: 1)

      expect(space).to be_a Space
      expect(space.description).to eq 'Boring description'
      expect(space.price).to eq '22.34'
    end
  end

  describe '.specific_space' do
    it 'returns a specific space' do
      DatabaseConnection.query('INSERT INTO users (id) VALUES ($1)', [1])

      result = Space.add(name: 'New space', 
        description: 'Hilarious fun description', 
        price: '22.34', 
        available_from: '01/02/2022', 
        available_to: '04/02/2022', 
        user_id: 1)
      
      space = Space.specific_space(result.id)

      expect(space).to be_a Space
      expect(space.name).to eq 'New space'
      expect(space.description).to eq 'Hilarious fun description'
    end
  end
end
