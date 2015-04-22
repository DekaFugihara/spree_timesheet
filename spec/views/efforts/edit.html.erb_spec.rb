require 'spec_helper'

describe "efforts/edit" do
  before(:each) do
    @effort = assign(:effort, stub_model(Effort,
      :user_id => 1,
      :task_id => 1,
      :object_id => 1,
      :object_type => "MyString",
      :description => "MyString",
      :amount => 1.5
    ))
  end

  it "renders the edit effort form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", effort_path(@effort), "post" do
      assert_select "input#effort_user_id[name=?]", "effort[user_id]"
      assert_select "input#effort_task_id[name=?]", "effort[task_id]"
      assert_select "input#effort_object_id[name=?]", "effort[object_id]"
      assert_select "input#effort_object_type[name=?]", "effort[object_type]"
      assert_select "input#effort_description[name=?]", "effort[description]"
      assert_select "input#effort_amount[name=?]", "effort[amount]"
    end
  end
end
