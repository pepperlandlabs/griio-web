require "minitest_helper"

describe SessionsController do
  it "routes to sessions/new" do
    assert_routing(
      { :path => "http://grillo.com/session/new", :method => :get },
      { :controller => "sessions", :action => "new" }
    )
  end

  it "routes to sessions/create" do
    assert_routing(
      { :path => "http://grillo.com/session", :method => :post },
      { :controller => "sessions", :action => "create" }
    )
  end

  it "routes to sessions/destroy" do
    assert_routing(
      { :path => "http://grillo.com/session", :method => :delete },
      { :controller => "sessions", :action => "destroy" }
    )
  end
end
