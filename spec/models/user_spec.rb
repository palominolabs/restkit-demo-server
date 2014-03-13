require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  context 'existing users' do
    subject { FactoryGirl.create(:user) }
    it { should_not validate_presence_of :password }
  end
end
