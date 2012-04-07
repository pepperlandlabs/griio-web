require "minitest_helper"

describe HomeController do
  it "routes to #index" do
    assert_routing(
      { :path => "http://grillo.com", :method => :get },
      { :controller => "home", :action => "index" }
    )
  end
end
