require 'spec_helper'

describe BeerReviewedActivitySerializer do
  it 'creates a json response for the BeerReviewedActivity' do
    beer_reviewed_activity = FactoryGirl.build :beer_reviewed_activity
    serializer = BeerReviewedActivitySerializer.new beer_reviewed_activity
    serializer.stub(:serialize) do |association|
      case association.name
        when 'review'
          'review_data'
      end
    end

    expected_response = {
        beer_reviewed_activity: {
            id: nil,
            type: 'BeerReviewedActivity',
            review: 'review_data'
        }
    }.with_indifferent_access
    expect(JSON.parse(serializer.to_json)).to eql expected_response
  end
end