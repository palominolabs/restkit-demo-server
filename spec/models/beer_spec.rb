require 'spec_helper'

describe Beer do
  it { should validate_presence_of :name }
  it { should validate_presence_of :brewery }
end
