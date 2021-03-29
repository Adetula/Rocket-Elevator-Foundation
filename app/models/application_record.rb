class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  config.session_store :cookie_store
  config.middleware.use ActionDispatch::Cookies
  config.middleware.use ActionDispatch::Session::CookieStore, config.session_options
  config.middleware.use Rack::MethodOverride
end
