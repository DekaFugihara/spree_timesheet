require 'spec_helper'

describe "time_sheets/show" do
  before(:each) do
    @time_sheet = assign(:time_sheet, stub_model(TimeSheet,
      :user_id => 1,
      :obs => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
  end
end
