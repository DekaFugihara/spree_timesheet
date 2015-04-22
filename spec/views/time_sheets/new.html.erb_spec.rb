require 'spec_helper'

describe "time_sheets/new" do
  before(:each) do
    assign(:time_sheet, stub_model(TimeSheet,
      :user_id => 1,
      :obs => "MyText"
    ).as_new_record)
  end

  it "renders new time_sheet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", time_sheets_path, "post" do
      assert_select "input#time_sheet_user_id[name=?]", "time_sheet[user_id]"
      assert_select "textarea#time_sheet_obs[name=?]", "time_sheet[obs]"
    end
  end
end
