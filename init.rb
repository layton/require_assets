require 'require_assets'

ActionView::Base.class_eval do
  include ::RequireAssets::Helpers
end