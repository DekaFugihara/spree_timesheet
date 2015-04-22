require 'spec_helper'

describe "efforts/show" do
  before(:each) do
    @effort = assign(:effort, stub_model(Effort,
      :user_id => 1,
      :task_id => 2,
      :object_id => 3,
      :object_type => "Object Type",
      :description => "Description",
      :amount => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Object Type/)
    rendered.should match(/Description/)
    rendered.should match(/1.5/)
  end
end
