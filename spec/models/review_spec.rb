require 'spec_helper'

describe Review do
  it { should validate_presence_of :rating }
  it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(5).only_integer }
  it { should validate_presence_of :beer }
  it { should belong_to :beer }
  it { should belong_to :user }
end
