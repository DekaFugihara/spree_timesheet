require "spec_helper"

describe TimeSheetsController do
  describe "routing" do

    it "routes to #index" do
      get("/time_sheets").should route_to("time_sheets#index")
    end

    it "routes to #new" do
      get("/time_sheets/new").should route_to("time_sheets#new")
    end

    it "routes to #show" do
      get("/time_sheets/1").should route_to("time_sheets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/time_sheets/1/edit").should route_to("time_sheets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/time_sheets").should route_to("time_sheets#create")
    end

    it "routes to #update" do
      put("/time_sheets/1").should route_to("time_sheets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/time_sheets/1").should route_to("time_sheets#destroy", :id => "1")
    end

  end
end
