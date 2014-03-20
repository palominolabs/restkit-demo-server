require 'spec_helper'

describe ReviewSerializer do
  it 'creates a json response for the Review' do
    review = FactoryGirl.build :review, {rating: 2, comment: 'some comment'}
    serializer = ReviewSerializer.new review
    serializer.stub(:serialize) do |association|
      case association.name
        when 'user'
            'user_data'
        when 'beer'
            'beer_data'
      end
    end

    expected_response = {
        review: {
            id: nil,
            rating: 2,
            comment: 'some comment',
            beer: 'beer_data',
            user: 'user_data'
        }
    }.with_indifferent_access
    expect(JSON.parse(serializer.to_json)).to eql expected_response
  end
end