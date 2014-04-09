require 'spec_helper'

describe BrewerySerializer do
  it 'creates a json response for the brewery' do
    brewery = FactoryGirl.build :brewery, {name: 'brewery name'}
    serializer = BrewerySerializer.new brewery
    serializer.stub(:serialize_ids) do |association|
      case association.name
        when 'beers'
          'beers array'
      end
    end

    expected_response = {
        brewery: {
            id: nil,
            name: 'brewery name',
            beer_ids: 'beers array'
        }
    }.with_indifferent_access
    expect(JSON.parse(serializer.to_json)).to eql expected_response
  end
end