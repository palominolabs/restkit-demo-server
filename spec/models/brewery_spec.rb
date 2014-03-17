require 'spec_helper'

describe Brewery do
  it { should validate_presence_of :name }
  it { should have_many(:beers).dependent :destroy }
end
