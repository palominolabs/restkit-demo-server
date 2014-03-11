require 'spec_helper'

describe ReviewsController do

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Review' do
        beer = FactoryGirl.create(:beer)
        valid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: beer.id })

        expect {
          post :create, review: valid_attributes
        }.to change(Review, :count).by(1)
      end

      it 'assigns a newly created review as @review' do
        beer = FactoryGirl.create(:beer)
        valid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: beer.id })

        post :create, review: valid_attributes
        assigns(:review).should be_a(Review)
        assigns(:review).should be_persisted
      end

      it 'redirects to the associated beer' do
        beer = FactoryGirl.create(:beer)
        valid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: beer.id })

        post :create, review: valid_attributes
        response.should redirect_to(beer)
      end
    end

    describe 'with invalid params' do
      describe 'with invalid beer_id' do
        it 'raises an error' do
          Beer.any_instance.stub(:find).and_return(false)
          Review.any_instance.stub(:save).and_return(false)
          invalid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: nil })
          expect { post :create, review: invalid_attributes
          }.to raise_error
        end
      end

      describe 'with valid beer but invalid review params' do
        it 'redirects to beers page' do
          beer = FactoryGirl.create(:beer)
          valid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: beer.id })

          Review.any_instance.stub(:save).and_return(false)
          post :create, review: valid_attributes
          response.should render_template('beers/show')
        end
      end
    end
  end
end
