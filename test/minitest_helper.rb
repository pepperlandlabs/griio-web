ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "turn/autorun"
require "capybara/rails"
require 'rails/test_help'

class MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  include ActiveRecord::TestFixtures

  alias :method_name :__name__ if defined? :__name__
end

class IntegrationSpec < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  register_spec_type(/integration$/, self)
end

class ControllerSpec < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include ActionController::TestCase::Behavior

  before do
    @routes = Rails.application.routes
  end

  def build_message(head, template=nil, *arguments)
    template &&= template.chomp
    template.gsub(/\?/) { mu_pp(arguments.shift) }
  end

  class << self
    alias :context :describe
  end

  register_spec_type(/Controller$/, self)
end

class HelperSpec < MiniTest::Spec
  include ActionView::TestCase::Behavior
  register_spec_type(/Helper$/, self)
end

Turn.config do |c|
  c.format = :progress
  c.natural = true
end
