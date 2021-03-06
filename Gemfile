source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'httpclient'
gem 'activerecord-import'
gem 'paranoia' # bin/rails generate migration AddDeletedAtToTicker deleted_at:datetime:index


group :development, :test do
  # 環境のバナー
  gem 'rack-dev-mark'

  # debug
  gem 'pry-rails' # binding.pry
  gem 'pry-byebug'
  gem 'awesome_print' # pretty prints Ruby objects in full color exposing: use ".pryrc"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # 開発速度を早める（ファイルを前もって読み込む）
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # Generate spring files => bundle exec spring binstub --all
  # Additional commands => https://github.com/rails/spring#additional-commands
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # 自動実行設定: rails g annotate:install => lib/tasks/auto_annotate_models.rake
  # 手動実行: bundle exec annotate --models
  gem 'annotate'

  gem 'solargraph'

end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
