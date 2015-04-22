require 'spec_helper'

describe "efforts/index" do
  before(:each) do
    assign(:efforts, [
      stub_model(Effort,
        :user_id => 1,
        :task_id => 2,
        :object_id => 3,
        :object_type => "Object Type",
        :description => "Description",
        :amount => 1.5
      ),
      stub_model(Effort,
        :user_id => 1,
        :task_id => 2,
        :object_id => 3,
        :object_type => "Object Type",
        :description => "Description",
        :amount => 1.5
      )
    ])
  end

  it "renders a list of efforts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Object Type".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
