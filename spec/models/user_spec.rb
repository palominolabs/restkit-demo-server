require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:reviews).dependent :destroy }
  it { should have_many(:reviewed_beers) }

  context 'existing users' do
    subject { FactoryGirl.create(:user) }
    it { should_not validate_presence_of :password }
  end
end
