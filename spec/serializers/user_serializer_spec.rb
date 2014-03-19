require 'spec_helper'

describe UserSerializer do
  context 'current_user is not authorized' do
    it 'creates a json response for the User without email' do
      user = FactoryGirl.build :user, {name: 'user name', email: 'user email'}
      serializer = UserSerializer.new user, {scope: nil}

      expected_response = {
          user: {
              id: nil,
              name: 'user name'
          }
      }.with_indifferent_access
      expect(JSON.parse(serializer.to_json)).to eql expected_response
    end
  end

  context 'current_user is authorized' do
    it 'creates a json response for the User without email' do
      scope_user = FactoryGirl.create(:user)
      user = FactoryGirl.build :user, {name: 'user name', email: 'user email'}
      serializer = UserSerializer.new user, {scope: scope_user}

      expected_response = {
          user: {
              id: nil,
              name: 'user name',
              email: 'user email'
          }
      }.with_indifferent_access
      expect(JSON.parse(serializer.to_json)).to eql expected_response
    end
  end
end
