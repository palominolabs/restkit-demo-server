require 'spec_helper'

describe BreweryBaseSerializer do
  it 'creates a basic json response for the Brewery' do
    brewery = FactoryGirl.build :brewery, {name: 'brewery name'}
    serializer = BreweryBaseSerializer.new brewery

    expected_response = {
        brewery: {
            id: nil,
            name: 'brewery name'
        }
    }.with_indifferent_access
    expect(JSON.parse(serializer.to_json)).to eql expected_response
  end
end