require 'spec_helper'

describe BeerSerializer do
  it 'creates a json response for the Beer' do
    beer = FactoryGirl.build :beer, {name: 'beer name', inventory: 5}
    beer.stub(:average_rating) {3}
    serializer = BeerSerializer.new beer
    serializer.stub(:serialize) do |association|
      case association.name
        when 'brewery'
          expect(association.serializer_from_options).to be BreweryBaseSerializer
          'brewery_data'
      end
    end

    expected_response = {
        beer: {
            id: nil,
            name: 'beer name',
            inventory: 5,
            average_rating: 3,
            reviews_count: nil,
            brewery: 'brewery_data'
        }
    }.with_indifferent_access
    expect(JSON.parse(serializer.to_json)).to eql expected_response
  end
end