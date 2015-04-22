require 'spec_helper'

describe "time_sheets/edit" do
  before(:each) do
    @time_sheet = assign(:time_sheet, stub_model(TimeSheet,
      :user_id => 1,
      :obs => "MyText"
    ))
  end

  it "renders the edit time_sheet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", time_sheet_path(@time_sheet), "post" do
      assert_select "input#time_sheet_user_id[name=?]", "time_sheet[user_id]"
      assert_select "textarea#time_sheet_obs[name=?]", "time_sheet[obs]"
    end
  end
end
