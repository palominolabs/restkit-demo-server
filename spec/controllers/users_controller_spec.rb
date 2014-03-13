require 'spec_helper'

describe UsersController do

  describe 'GET new' do
    it 'does not require authentication' do
      controller.should_not_receive :require_authentication
      get :new
    end

    it 'should be successful' do
      get :new
      response.should be_success
    end
  end

  describe 'POST create' do
    it 'does not require authentication' do
      controller.should_not_receive :require_authentication
      get :new
    end

    context 'user creation succeeds' do
      before do
        @user_params = FactoryGirl.attributes_for(:user)
        post :create, user: @user_params
      end

      it 'should assign @user to the new user' do
        assigns(:user).should be_a User
        assigns(:user).email.should eql @user_params[:email]
      end

      it 'should redirect to root_url with notice' do
        should redirect_to root_url
        should set_the_flash[:notice].to 'Signed up!'
      end
    end

    context 'fails to save user' do
      it 'should render new user template' do
        User.any_instance.should_receive(:save).and_return(false)
        user_params = FactoryGirl.attributes_for(:user)
        post :create, user: user_params

        should render_template :new
      end
    end


  end

end
