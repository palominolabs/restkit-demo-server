require 'spec_helper'

describe SessionsController do

  describe 'GET new' do
    it 'returns http success' do
      get 'new'
      response.should be_success
    end
  end

  describe 'POST create' do
    before do
      @user = FactoryGirl.create(:user)
      @login_form_params = FactoryGirl.attributes_for(:user)
      @login_form_params.slice!(:password)
      @login_form_params[:email] = @user.email
    end

    it 'does not require authentication' do
      controller.should_not_receive :require_authentication
      post :create, @login_form_params
    end

    context 'successful authentication' do
      before do
        User.any_instance.should_receive(:authenticate).and_return(true)
        post :create, @login_form_params
      end

      it 'sets the session :user_id' do
        session[:user_id].should eql @user.id
      end

      it 'redirects to root_url with notice' do
        should redirect_to root_url
        should set_the_flash[:notice].to 'Logged in!'
      end
    end

    context 'fails authentication' do
      it 'renders :new with flash alert' do
        User.should_receive(:find_by_email).and_return(nil)
        post :create, @login_form_params
        should set_the_flash[:alert].now.to 'Invalid email or password'
        should render_template :new
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
    end

    it 'requires authentication' do
      controller.should_receive :require_authentication
      delete :destroy
    end

    it 'should clear the current session :user_id' do
      controller.stub(:require_authentication)
      delete :destroy
      session[:user_id].should be_nil
    end

    it 'should redirect to root_url with notice' do
      controller.stub(:require_authentication)
      delete :destroy
      should redirect_to root_url
      should set_the_flash[:notice].to 'Logged out!'
    end
  end
end
