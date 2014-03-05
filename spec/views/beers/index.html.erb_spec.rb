require 'spec_helper'

describe "beers/index" do
  before(:each) do
    assign(:beers, [
      stub_model(Beer,
        :name => "Name",
        :brewery => "Brewery"
      ),
      stub_model(Beer,
        :name => "Name",
        :brewery => "Brewery"
      )
    ])
  end

  it "renders a list of beers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Brewery".to_s, :count => 2
  end
end
