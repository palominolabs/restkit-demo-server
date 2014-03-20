require 'spec_helper'

describe BeerAddedActivitySerializer do
  it 'creates a json response for the BeerAddedActivity' do
    beer_added_activity = FactoryGirl.build :beer_added_activity
    serializer = BeerAddedActivitySerializer.new beer_added_activity
    serializer.stub(:serialize) do |association|
      case association.name
        when 'user'
          'user_data'
        when 'beer'
          'beer_data'
      end
    end

    expected_response = {
      beer_added_activity: {
        id: nil,
        type: 'BeerAddedActivity',
        beer: 'beer_data',
        user: 'user_data'
      }
    }.with_indifferent_access
    expect(JSON.parse(serializer.to_json)).to eql expected_response
  end
end