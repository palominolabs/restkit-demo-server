require 'spec_helper'

describe BeersController do

  describe 'GET index' do
    it 'assigns all beers as @beers' do
      beer = FactoryGirl.create(:beer)
      get :index, {}
      assigns(:beers).should eq [beer]
    end
  end

  describe 'GET show' do
    it 'assigns the requested beer as @beer' do
      beer = FactoryGirl.create(:beer)
      get :show, {:id => beer.to_param}
      assigns(:beer).should eq beer
    end

    it 'assigns a new review to @review' do
      beer = FactoryGirl.create(:beer)
      get :show, {:id => beer.to_param}
      assigns(:review).should be_a_new Review
    end
  end

  describe 'GET new' do
    it 'assigns a new beer as @beer' do
      get :new, {}
      assigns(:beer).should be_a_new Beer
    end
  end

  describe 'GET edit' do
    it 'assigns the requested beer as @beer' do
      beer = FactoryGirl.create(:beer)
      get :edit, {:id => beer.to_param}
      assigns(:beer).should eq beer
    end
  end
  
  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new Beer' do
        expect {
          post :create, {:beer => FactoryGirl.attributes_for(:beer)}
        }.to change(Beer, :count).by 1
      end

      it 'assigns a newly created beer as @beer' do
        post :create, {:beer => FactoryGirl.attributes_for(:beer)}
        assigns(:beer).should be_a Beer
        assigns(:beer).should be_persisted
      end

      it 'redirects to the created beer' do
        post :create, {:beer => FactoryGirl.attributes_for(:beer)}
        response.should redirect_to Beer.last
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved beer as @beer' do
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        post :create, {:beer => { 'name' => 'invalid value' }}
        assigns(:beer).should be_a_new Beer
      end

      it 're-renders the \'new\' template' do
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        post :create, {:beer => { 'name' => 'invalid value' }}
        response.should render_template :new
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      it 'updates the requested beer' do
        beer = FactoryGirl.create(:beer)
        # Assuming there are no other beers in the database, this
        # specifies that the Beer created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Beer.any_instance.should_receive(:update).with({ 'name' => 'MyString' })
        put :update, {:id => beer.to_param, :beer => { 'name' => 'MyString' }}
      end

      it 'assigns the requested beer as @beer' do
        beer = FactoryGirl.create(:beer)
        put :update, {:id => beer.to_param, :beer => FactoryGirl.attributes_for(:beer)}
        assigns(:beer).should eq beer
      end

      it 'redirects to the beer' do
        beer = FactoryGirl.create(:beer)
        put :update, {:id => beer.to_param, :beer => FactoryGirl.attributes_for(:beer)}
        response.should redirect_to beer
      end
    end

    context 'with invalid params' do
      it 'assigns the beer as @beer' do
        beer = FactoryGirl.create(:beer)
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        put :update, {:id => beer.to_param, :beer => { 'name' => 'invalid value' }}
        assigns(:beer).should eq beer
      end

      it 're-renders the \'edit\' template' do
        beer = FactoryGirl.create(:beer)
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        put :update, {:id => beer.to_param, :beer => { 'name' => 'invalid value' }}
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested beer' do
      beer = FactoryGirl.create(:beer)
      expect {
        delete :destroy, {:id => beer.to_param}
      }.to change(Beer, :count).by -1
    end

    it 'redirects to the beers list' do
      beer = FactoryGirl.create(:beer)
      delete :destroy, {:id => beer.to_param}
      response.should redirect_to beers_url
    end
  end

end
