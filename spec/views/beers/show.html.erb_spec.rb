require 'spec_helper'

describe "beers/show" do
  before(:each) do
    @beer = assign(:beer, stub_model(Beer,
      :name => 'Name',
      :brewery => 'Brewery'
    ))
    @review = assign(:reivew, stub_model(Review,
      :reviewer => 'Hayden',
      :rating => 5,
      :comment => 'This is a comment'
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Brewery/)
    rendered.should match(/Reviews/)
    rendered.should match(/Add a Review/)
  end
end
