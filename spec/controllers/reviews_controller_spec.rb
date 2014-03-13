require 'spec_helper'

describe ReviewsController do

  describe 'POST create' do
    it 'requires authentication' do
      beer = FactoryGirl.create(:beer)
      valid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: beer.id })
      controller.should_receive :require_authentication
      post :create, review: valid_attributes
    end

    context 'with valid params' do
      before do
        controller.stub(:require_authentication)
        @beer = FactoryGirl.create(:beer)
        @valid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: @beer.id })
      end

      it 'creates a new Review' do
        expect {
          post :create, review: @valid_attributes
        }.to change(Review, :count).by 1
      end

      it 'assigns a newly created review as @review' do
        post :create, review: @valid_attributes
        assigns(:review).should be_a Review
        assigns(:review).should be_persisted
      end

      it 'redirects to the associated beer' do
        post :create, review: @valid_attributes
        should redirect_to @beer
      end
    end

    context 'with invalid params' do
      before do
        controller.stub(:require_authentication)
      end

      context 'with invalid beer_id' do
        it 'raises an error' do
          Beer.any_instance.stub(:find).and_return(false)
          Review.any_instance.stub(:save).and_return(false)
          invalid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: nil })
          expect { post :create, review: invalid_attributes
          }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context 'with valid beer but invalid review params' do
        it 'redirects to beers page' do
          beer = FactoryGirl.create(:beer)
          valid_attributes = FactoryGirl.attributes_for(:review, { beer: nil, beer_id: beer.id })
          Review.any_instance.should_receive(:save).and_return(false)

          post :create, review: valid_attributes
          should render_template 'beers/show'
        end
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      @beer = FactoryGirl.create(:beer)
      @review = FactoryGirl.create(:review, { beer: @beer, beer_id: @beer.id })
    end

    it 'requires authentication' do
      controller.should_receive :require_authentication
      delete :destroy, id: @review.id
    end

    it 'destroys the requested review' do
      controller.stub(:require_authentication)
      expect {
        delete :destroy, id: @review.id
      }.to change(Review, :count).by -1
    end

    it 'assigns the target beer to @beer' do
      controller.stub(:require_authentication)
      delete :destroy, id: @review.id

      assigns(:beer).should be_a Beer
    end

    it 'render beer#show' do
      controller.stub(:require_authentication)
      delete :destroy, id: @review.id

      should render_template 'beers/show'
    end
  end
end
