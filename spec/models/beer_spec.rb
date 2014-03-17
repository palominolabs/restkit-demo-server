require 'spec_helper'

describe Beer do
  it { should validate_presence_of :name }
  it { should validate_presence_of :brewery }
  it { should belong_to :brewery }
  it { should have_many(:reviews).dependent :destroy }
  it { should have_many(:reviewers) }

  describe '#average_rating' do
    it 'should return the average rating for the given beer' do
      beer = FactoryGirl.create(:beer)
      otherBeer = FactoryGirl.create(:beer)

      FactoryGirl.create(:review, { beer: beer, rating: 5 })
      FactoryGirl.create(:review, { beer: beer, rating: 3 })
      FactoryGirl.create(:review, { beer: otherBeer, rating: 1 })

      beer.average_rating.should eql 4
    end

    it 'should return nil if the given beer has no reviews' do
      beer = FactoryGirl.create(:beer)
      beer.average_rating.should be_nil
    end
  end
end
