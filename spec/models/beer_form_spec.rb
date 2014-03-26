require 'spec_helper'

describe BeerForm do
  it { should validate_presence_of :name }
  it { should validate_presence_of :brewery_id }
  it { should validate_presence_of :inventory }
  it { should validate_numericality_of(:inventory).is_greater_than_or_equal_to(0).only_integer }
end
