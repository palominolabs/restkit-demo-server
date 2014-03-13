require 'spec_helper'

describe ApplicationController do
  class SpecApplicationController < ApplicationController ; end

  controller(SpecApplicationController) do
    def index
      flash.now[:info] = 'Authenticated'
      render nothing: true
    end
  end

  describe '#require_authentication' do
    context 'session has no :user_id' do
      it 'should do nothing' do
        session[:user_id] = nil
        get :index
        should set_the_flash[:error].to 'You must be logged in to access this section.'
        should redirect_to log_in_url
      end
    end

    context 'session has a :user_id' do
      it 'should flash and redirect to log_in_url' do
        user = FactoryGirl.create(:user)
        session[:user_id] = user.id
        get :index
        should set_the_flash[:info].now.to 'Authenticated'
        assigns[:current_user].should be_a User
        assigns[:current_user].email.should eql user.email
        should_not redirect_to log_in_url
      end
    end
  end
end