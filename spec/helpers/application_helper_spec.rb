require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the BeersHelper. For example:
#
# describe BeersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe BeersHelper do
  describe '#flash_class' do
    it 'returns correct alert for :notice level' do
      helper.flash_class(:notice).should eql 'alert alert-dismissable alert-info'
    end

    it 'returns correct alert for :success level' do
      helper.flash_class(:success).should eql 'alert alert-dismissable alert-success'
    end

    it 'returns correct alert for :error level' do
      helper.flash_class(:error).should eql 'alert alert-dismissable alert-danger'
    end

    it 'returns correct alert for :alert level' do
      helper.flash_class(:alert).should eql 'alert alert-dismissable alert-danger'
    end

    it 'returns default alert for unknown level' do
      helper.flash_class(nil).should eql 'alert alert-dismissable '
    end
  end

  describe '#current_sort_class' do
    it 'returns down arrow glyph for desc sort' do
      helper.current_sort_class('desc').should eql 'glyphicon glyphicon-arrow-down'
    end

    it 'returns up arrow glyph for asc sort' do
      helper.current_sort_class('asc').should eql 'glyphicon glyphicon-arrow-up'
    end
  end
end
