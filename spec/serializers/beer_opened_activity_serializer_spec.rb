require 'spec_helper'

describe BeerOpenedActivitySerializer do
  it 'creates a json response for the BeerOpenedActivity' do
    beer_opened_activity = FactoryGirl.build :beer_opened_activity
    serializer = BeerOpenedActivitySerializer.new beer_opened_activity
    serializer.stub(:serialize) do |association|
      case association.name
        when 'user'
          'user_data'
        when 'beer'
          'beer_data'
      end
    end

    expected_response = {
        beer_opened_activity: {
            id: nil,
            type: 'BeerOpenedActivity',
            beer: 'beer_data',
            user: 'user_data'
        }
    }.with_indifferent_access
    expect(JSON.parse(serializer.to_json)).to eql expected_response
  end
end