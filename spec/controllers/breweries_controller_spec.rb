require 'spec_helper'

describe BreweriesController do
  before do
    @valid_attributes = FactoryGirl.attributes_for(:brewery)
  end

  describe 'GET index' do
    before do
      @brewery = Brewery.create! @valid_attributes
    end

    it 'does not require authentication' do
      controller.should_not_receive :require_authentication
      get :index, {}
    end

    it 'assigns all breweries as @breweries' do
      get :index, {}
      assigns(:breweries).should eq([@brewery])
    end
  end

  describe 'GET show' do
    before do
      @brewery = Brewery.create! @valid_attributes
    end

    it 'does not require authentication' do
      controller.should_not_receive :require_authentication
      get :show, {id: @brewery.to_param}
    end

    it 'assigns the requested brewery as @brewery' do
      get :show, {id: @brewery.to_param}
      assigns(:brewery).should eq(@brewery)
    end
  end

  describe 'GET new' do
    it 'requires authentication' do
      session[:user_id] = nil
      controller.should_receive :require_authentication
      get :new, {}
    end

    context 'with authenticated session' do
      it 'assigns a new brewery as @brewery' do
        controller.stub(:require_authentication)
        get :new, {}
        assigns(:brewery).should be_a_new(Brewery)
      end
    end
  end

  describe 'GET edit' do
    before do
      @brewery = Brewery.create! @valid_attributes
    end

    it 'requires authentication' do
      session[:user_id] = nil
      controller.should_receive :require_authentication
      get :edit, {id: @brewery.to_param}
    end

    context 'with authenticated session' do
      it 'assigns the requested brewery as @brewery' do
        controller.stub(:require_authentication)
        get :edit, {id: @brewery.to_param}
        assigns(:brewery).should eq(@brewery)
      end
    end
  end

  describe 'POST create' do
    it 'requires authentication' do
      session[:user_id] = nil
      controller.should_receive :require_authentication
      post :create, {brewery: @valid_attributes}
    end

    context 'with authenticated session' do
      before do
        controller.stub(:require_authentication)
      end

      describe 'with valid params' do
        it 'creates a new Brewery' do
          expect {
            post :create, {brewery: @valid_attributes}
          }.to change(Brewery, :count).by(1)
        end

        it 'assigns a newly created brewery as @brewery' do
          post :create, {brewery: @valid_attributes}
          assigns(:brewery).should be_a(Brewery)
          assigns(:brewery).should be_persisted
        end

        it 'redirects to the created brewery' do
          post :create, {brewery: @valid_attributes}
          response.should redirect_to(Brewery.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved brewery as @brewery' do
          # Trigger the behavior that occurs when invalid params are submitted
          Brewery.any_instance.stub(:save).and_return(false)
          post :create, {brewery: { name: 'invalid value' }}
          assigns(:brewery).should be_a_new(Brewery)
        end

        it 're-renders the \'new\' template' do
          # Trigger the behavior that occurs when invalid params are submitted
          Brewery.any_instance.stub(:save).and_return(false)
          post :create, {brewery: { name: 'invalid value' }}
          response.should render_template('new')
        end
      end
    end
  end

  describe 'PUT update' do
    before do
      @brewery = Brewery.create!@valid_attributes
    end

    it 'requires authentication' do
      session[:user_id] = nil
      controller.should_receive :require_authentication
      put :update, {id: @brewery.to_param, brewery: { name: 'Stone Brewery' }}
    end

    context 'with authenticated session' do
      before do
        controller.stub(:require_authentication)
      end

      describe 'with valid params' do
        it 'updates the requested brewery' do
          Brewery.any_instance.should_receive(:update).with({ 'name' => 'Stone Brewery' })
          put :update, {id: @brewery.to_param, brewery: { name: 'Stone Brewery' }}
        end

        it 'assigns the requested brewery as @brewery' do
          put :update, {id: @brewery.to_param, brewery:@valid_attributes}
          assigns(:brewery).should eq(@brewery)
        end

        it 'redirects to the brewery' do
          put :update, {id: @brewery.to_param, brewery:@valid_attributes}
          response.should redirect_to(@brewery)
        end
      end

      describe 'with invalid params' do
        it 'assigns the brewery as @brewery' do
          # Trigger the behavior that occurs when invalid params are submitted
          Brewery.any_instance.stub(:save).and_return(false)
          put :update, {id: @brewery.to_param, brewery: { name: 'invalid value' }}
          assigns(:brewery).should eq(@brewery)
        end

        it 're-renders the \'edit\' template' do
          # Trigger the behavior that occurs when invalid params are submitted
          Brewery.any_instance.stub(:save).and_return(false)
          put :update, {id: @brewery.to_param, brewery: { name: 'invalid value' }}
          response.should render_template('edit')
        end
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      @brewery = Brewery.create!@valid_attributes
    end

    it 'requires authentication' do
      session[:user_id] = nil
      controller.should_receive :require_authentication
      delete :destroy, {id: @brewery.to_param}
    end

    context 'with authenticated session' do
      before do
        controller.stub(:require_authentication)
      end
      it 'destroys the requested brewery' do
        expect {
          delete :destroy, {id: @brewery.to_param}
        }.to change(Brewery, :count).by(-1)
      end

      it 'redirects to the breweries list' do
        delete :destroy, {id: @brewery.to_param}
        response.should redirect_to(breweries_url)
      end
    end
  end
end
