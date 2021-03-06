require 'spec_helper'

describe "time_sheets/index" do
  before(:each) do
    assign(:time_sheets, [
      stub_model(TimeSheet,
        :user_id => 1,
        :obs => "MyText"
      ),
      stub_model(TimeSheet,
        :user_id => 1,
        :obs => "MyText"
      )
    ])
  end

  it "renders a list of time_sheets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
