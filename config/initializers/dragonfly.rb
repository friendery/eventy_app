require 'dragonfly'

# Configure
Dragonfly.app.configure do |c|
  plugin :imagemagick

  protect_from_dos_attacks true
  secret "a96a5d47b48dc8f79da9072066bbeeffb32919f14c64a71bcb690c82d2792ee3"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
