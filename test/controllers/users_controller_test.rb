require "minitest_helper"

describe UsersController do
  it "routes to users/new" do
    assert_routing(
      { :path => "http://grillo.com/users/new", :method => :get },
      { :controller => "users", :action => "new" }
    )
  end

  it "routes to users/create" do
    assert_routing(
      { :path => "http://grillo.com/users", :method => :post },
      { :controller => "users", :action => "create" }
    )
  end
end
