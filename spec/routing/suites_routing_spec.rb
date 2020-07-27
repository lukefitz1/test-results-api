require "rails_helper"

RSpec.describe SuitesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/suites").to route_to("suites#index")
    end

    it "routes to #show" do
      expect(:get => "/suites/1").to route_to("suites#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/suites").to route_to("suites#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/suites/1").to route_to("suites#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/suites/1").to route_to("suites#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/suites/1").to route_to("suites#destroy", :id => "1")
    end
  end
end
