# All routes specific to a subdomain live in config/routes.

class SubdomainConstraint
  def initialize(subdomain)
    @subdomain = "#{subdomain}."
  end

  def matches?(request)
    request.host.starts_with? @subdomain
  end
end

class UnrecognizedSubdomainConstraint
  def initialize(subdomains)
    @subdomains = subdomains
  end

  def matches?(request)
    !@subdomains.any? {|s| request.subdomain == s }
  end
end

class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  def draw_subdomain(subdomain_name)
    constraints SubdomainConstraint.new(subdomain_name) do
      scope module: subdomain_name, as: subdomain_name do
        draw subdomain_name
      end
    end
  end
end

SUBDOMAINS = %w(api)

GriioWeb::Application.routes.draw do
  constraints(SubdomainConstraint.new('www')) do
    root to: redirect {|p, req| req.url.sub("//www.", "//") }
    match '/*path', to: redirect {|p, req| req.url.sub("//www.", "//") }
  end

  SUBDOMAINS.each {|s| draw_subdomain s }

  constraints UnrecognizedSubdomainConstraint.new(SUBDOMAINS) do
    scope module: 'web', as: 'web' do
      draw :web
    end
  end
end
