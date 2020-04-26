require 'sinatra/activerecord/rake'
require './app/app.rb'

desc "run irb console"
task :console, :environment do |t, args|
  ENV['RACK_ENV'] = args[:environment] || 'development'

  exec "irb -r irb/completion -r ./app/app.rb"
end