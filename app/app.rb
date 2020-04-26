require 'sinatra'
require 'trailblazer'
require 'sinatra/activerecord'

# require debugger for non prod envs
if ENV['RACK_ENV'] != 'production'
  require 'byebug'
end

# Load files
require_relative 'concepts/customer/customer.rb'
require_relative 'concepts/customer/operation/create.rb'
require_relative 'concepts/customer/operation/list.rb'
require_relative 'concepts/customer/operation/retrieve.rb'


##############################
# Configuration
##############################
set :database_file, 'config/database.yml'
set :bind, '0.0.0.0'
PORT = ENV['PORT'] || '3000'
set :port, PORT

VERSION = File.open("VERSION").read
ENVIRONMENT = ENV['RACK_ENV'] || 'development'
puts "ENVIRONMENT: #{ENVIRONMENT}"

if ENVIRONMENT != 'production'
  puts "ENV:"
  pp ENV
end

# byebug

# set json as content type for all requests
before do
  content_type 'application/json'
end

# info endpoint
get '/info' do
  info = {
    name: 'spring_api_example_1',
    version: VERSION
  }
  response.body = info.to_json
end

# health stats
get '/health' do
  {
    todo: 'todo'
  }.to_json
end

# main route
get '/' do
  {
    message: 'Hello world!'
  }.to_json
end

# redirection example
get '/redirect' do
  redirect '/info'
end

##########################
# Customer Endpoints
##########################

# retrieve a list of customers
get '/customers' do
  res = Customer::List.(params)
  if res.success?
    response.body = {
      count: res[:model].count,
      results: res[:model].to_a
    }
  else
    return_error response,
      500,
      "An unexpected error occured while retrieving models from the database!"
  end
end

# create customer
post '/customers' do
  res = Customer::Create.(params)
  if res.success?
    res[:model].to_s.to_json
  else
    response.status = 500
    'ERROR'
  end
end

# get specific customer by id
get '/customers/:id' do
  "#{params[:id]}"
end

# helpers

def return_error(response, error_code, message)
  response.body = {
    error_message: message,
    status: error_code
  }
  response.status = error_code
end
