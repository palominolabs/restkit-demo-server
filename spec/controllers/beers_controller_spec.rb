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
      get :show, {id: beer.to_param}
      assigns(:beer).should eq beer
    end

    it 'assigns a new review to @review' do
      beer = FactoryGirl.create(:beer)
      get :show, {id: beer.to_param}
      assigns(:review).should be_a_new Review
    end
  end

  describe 'GET new' do
    it 'requires authentication' do
      controller.should_receive :require_authentication
      get :new, {}
    end

    it 'assigns a new beer as @beer' do
      controller.stub(:require_authentication)
      get :new, {}
      assigns(:beer).should be_a_new Beer
    end
  end

  describe 'GET edit' do
    it 'requires authentication' do
      controller.should_receive :require_authentication
      get :new, {}
    end

    it 'assigns the requested beer as @beer' do
      controller.stub(:require_authentication)
      beer = FactoryGirl.create(:beer)
      get :edit, {id: beer.to_param}
      assigns(:beer).should eq beer
    end
  end
  
  describe 'POST create' do
    it 'requires authentication' do
      controller.should_receive :require_authentication
      post :create, { beer: FactoryGirl.attributes_for(:beer) }
    end

    context 'with valid params' do
      before do
        controller.stub(:require_authentication)
      end

      it 'creates a new Beer' do
        expect {
          post :create, {beer: FactoryGirl.attributes_for(:beer)}
        }.to change(Beer, :count).by 1
      end

      it 'assigns a newly created beer as @beer' do
        post :create, {beer: FactoryGirl.attributes_for(:beer)}
        assigns(:beer).should be_a Beer
        assigns(:beer).should be_persisted
      end

      it 'redirects to the created beer' do
        post :create, {beer: FactoryGirl.attributes_for(:beer)}
        should redirect_to Beer.last
      end
    end

    context 'with invalid params' do
      before do
        controller.stub(:require_authentication)
      end

      it 'assigns a newly created but unsaved beer as @beer' do
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        post :create, {beer: { name: 'invalid value' }}
        assigns(:beer).should be_a_new Beer
      end

      it 're-renders the \'new\' template' do
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        post :create, {beer: { name: 'invalid value' }}
        should render_template :new
      end
    end
  end

  describe 'PUT update' do
    it 'requires authentication' do
      @beer = FactoryGirl.create(:beer)
      controller.should_receive :require_authentication
      put :update, {id: @beer.to_param, beer: FactoryGirl.attributes_for(:beer)}
    end

    context 'with valid params' do
      before do
        controller.stub(:require_authentication)
        @beer = FactoryGirl.create(:beer)
      end

      it 'updates the requested beer' do
        Beer.any_instance.should_receive(:update).with({ 'name' => 'Egregious' })
        put :update, {id: @beer.to_param, beer: { name: 'Egregious' }}
      end

      it 'assigns the requested beer as @beer' do
        put :update, {id: @beer.to_param, beer: FactoryGirl.attributes_for(:beer)}
        assigns(:beer).should be_a Beer
        assigns(:beer).id.should eql @beer.id
      end

      it 'redirects to the beer' do
        put :update, {id: @beer.to_param, beer: FactoryGirl.attributes_for(:beer)}
        should redirect_to @beer
      end
    end

    context 'with invalid params' do
      before do
        controller.stub(:require_authentication)
        @beer = FactoryGirl.create(:beer)
      end

      it 'assigns the beer as @beer' do
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        put :update, {id: @beer.to_param, beer: { name: 'invalid value' }}
        assigns(:beer).should eq @beer
      end

      it 're-renders the \'edit\' template' do
        # Trigger the behavior that occurs when invalid params are submitted
        Beer.any_instance.stub(:save).and_return(false)
        put :update, {id: @beer.to_param, beer: { name: 'invalid value' }}
        should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    it 'requires authentication' do
      controller.should_receive :require_authentication
      get :new, {}
    end

    it 'destroys the requested beer' do
      controller.stub(:require_authentication)
      beer = FactoryGirl.create(:beer)
      expect {
        delete :destroy, {id: beer.to_param}
      }.to change(Beer, :count).by -1
    end

    it 'redirects to the beers list' do
      controller.stub(:require_authentication)
      beer = FactoryGirl.create(:beer)
      delete :destroy, {id: beer.to_param}
      should redirect_to beers_url
    end
  end

end
