require 'require_assets'

ActionView::Base.class_eval do
  include ::RequireAssets::Helpers
end

ActionController::Base.class_eval do
  include ::RequireAssets::Helpers
end

ActionController::Base.extend(::RequireAssets::ClassMethods)