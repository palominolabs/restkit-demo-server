require 'spec_helper'

describe Brewery do
  it { should validate_presence_of :name }
  it { should have_many(:beers).dependent :destroy }

  describe '#average_rating' do
    before do
      @brewery = FactoryGirl.create(:brewery)
      FactoryGirl.create(:beer, {brewery_id: @brewery.id})
    end

    context 'no rated beers' do
      it 'should return nil' do
        @brewery.average_rating.should be_nil
      end
    end

    context 'has rated beers' do
      it 'should return a rounded average' do
        beer = FactoryGirl.create(:beer, {brewery_id: @brewery.id})
        FactoryGirl.create(:review, {beer_id: beer.id, rating: 4})
        FactoryGirl.create(:review, {beer_id: beer.id, rating: 5})
        FactoryGirl.create(:review, {beer_id: beer.id, rating: 1})
        @brewery.average_rating.should eql 3.3
      end
    end
  end
end
