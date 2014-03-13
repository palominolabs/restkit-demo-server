require 'spec_helper'

describe Review do
  it { should validate_presence_of :rating }
  it { should validate_presence_of :beer }
  it { should belong_to :beer }
  it { should belong_to :user }
end
