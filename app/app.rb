require 'sinatra'
require 'trailblazer'
require 'sinatra/activerecord'

# require debugger for non prod envs
if ENV['RACK_ENV'] != 'production'
  require 'byebug'
end

# Load files

# Representation layer
require_relative 'concepts/representation/representation.rb'
require_relative 'concepts/representation/item_representer.rb'
require_relative 'concepts/representation/list_representer.rb'

# customer concept
require_relative 'concepts/customer/customer.rb'
require_relative 'concepts/customer/operation/create.rb'
require_relative 'concepts/customer/operation/create_v2.rb'
require_relative 'concepts/customer/operation/list.rb'
require_relative 'concepts/customer/operation/retrieve.rb'
require_relative 'concepts/customer/operation/update.rb'
require_relative 'concepts/customer/operation/activate.rb'
require_relative 'concepts/customer/operation/deactivate.rb'

# record concept
require_relative 'concepts/record/record.rb'
require_relative 'concepts/record/operation/create.rb'
require_relative 'concepts/record/operation/list.rb'
require_relative 'concepts/record/operation/retrieve.rb'
require_relative 'concepts/record/operation/update.rb'

# movie concept
require_relative 'concepts/movie/movie.rb'
require_relative 'concepts/movie/operation/create.rb'
require_relative 'concepts/movie/operation/list.rb'
require_relative 'concepts/movie/operation/retrieve.rb'
require_relative 'concepts/movie/operation/update.rb'
require_relative 'concepts/movie/operation/rate.rb'

##############################
# Configuration
##############################
set :database_file, 'config/database.yml'
set :bind, '0.0.0.0'
PORT = ENV['PORT'] || '3000'
set :port, PORT

# set json as content type for all requests
before do
  content_type 'application/json'
end
mime_type :json, 'application/json'

VERSION = File.open("VERSION").read
ENVIRONMENT = ENV['RACK_ENV'] || 'development'
puts "ENVIRONMENT: #{ENVIRONMENT}"

if ENVIRONMENT != 'production' && ENVIRONMENT != 'test'
  puts "ENV:"
  pp ENV
end


##################################
#### Endpoints ###################s
##################################

# info endpoint
get '/v1/info' do
  info = {
    name: 'spring_api_example_1',
    version: VERSION
  }
  response.body = info.to_json
end

# health stats
get '/v1/health' do
  ActiveRecord::Base.connection.execute("SELECT * FROM customers LIMIT 1")
  response.status = 200
  response.body = {
    database: 'OK'
  }.to_json
rescue
  return_error response, 500, "Could not establish database connection"
end

# main route
get '/' do
  {
    message: 'Hello world!'
  }.to_json
end

# redirection example
get '/redirect' do
  redirect '/v1/info'
end

##########################
# Customer Endpoints
##########################

# retrieve a list of customers
get '/v1/customers' do
  res = Customer::List.(params)
  if res.success?
    response.body = ::Representation::ListRepresenter.new(res[:model]).to_json
    response.status = 200
  else
    return_error response,
      500,
      "An unexpected error occured while retrieving models from the database!"
  end
end

# create customer
post '/v1/customers' do
  payload = JSON.parse(request.body.read).symbolize_keys
  res = Customer::Create.(payload)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 201
  else
    return_error response,
      500,
      "An unexpected error occured while creating a customer!"
  end
end

# create customer V2 endpoint with email mock
post '/v2/customers' do
  payload = JSON.parse(request.body.read).symbolize_keys
  res = Customer::CreateV2.(payload)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 201
  else
    return_error response,
      500,
      "An unexpected error occured while creating a customer!"
  end
end

# get specific customer by id
get '/v1/customers/:id' do
  res = Customer::Retrieve.(params)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 200
  else
    return_error response,
      404,
      res[:error_message]
  end
end

# modify specific customer by id
put '/v1/customers/:id' do
  payload = JSON.parse(request.body.read)
  all_params = payload.merge(params).symbolize_keys
  res = Customer::Update.(all_params)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 202
  else
    return_error response,
      404,
      res[:error_message]
  end
end

put '/v1/customers/:id/activate' do
  res = Customer::Activate.(params)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 202
  else
    return_error response,
      500,
      "An unexpected error occured while activating a customer!"
  end
end

put '/v1/customers/:id/deactivate' do
  res = Customer::Deactivate.(params)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 202
  else
    return_error response,
      500,
      "An unexpected error occured while deactivating a customer!"
  end
end

##########################
# Record Endpoints
##########################

# list records
get '/v1/customers/:customer_id/records' do
  res = Record::List.(params)
  if res.success?
    response.body = ::Representation::ListRepresenter.new(res[:model]).to_json
    response.status = 200
  else
    return_error response,
      500,
      "An unexpected error occured while retrieving models from the database!"
  end
end

# get specific record by id and customer_id
get '/v1/customers/:customer_id/records/:id' do
  res = Record::Retrieve.(params)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 200
  else
    return_error response,
      404,
      res[:error_message]
  end
end

# create record
post '/v1/customers/:customer_id/records' do
  payload = JSON.parse(request.body.read).symbolize_keys
  res = Record::Create.(payload.merge(customer_id: params[:customer_id]))
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 201
  else
    return_error response,
      500,
      "An unexpected error occured while creating a record!"
  end
end

# modify specific record by id and customer_id
put '/v1/customers/:customer_id/records/:id' do
  payload = JSON.parse(request.body.read)
  all_params = payload.merge(params).symbolize_keys
  res = Record::Update.(all_params)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 202
  else
    return_error response,
      404,
      res[:error_message]
  end
end

##########################
# Movie Endpoints
##########################

# list records
get '/v1/customers/:customer_id/movies' do
  res = Movie::List.(params)
  if res.success?
    response.body = ::Representation::ListRepresenter.new(res[:model]).to_json
    response.status = 200
  else
    return_error response,
      500,
      "An unexpected error occured while retrieving models from the database!"
  end
end

# get specific record by id and customer_id
get '/v1/customers/:customer_id/movies/:id' do
  res = Movie::Retrieve.(params)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 200
  else
    return_error response,
      404,
      res[:error_message]
  end
end

# create record
post '/v1/customers/:customer_id/movies' do
  payload = JSON.parse(request.body.read).symbolize_keys
  res = Movie::Create.(payload.merge(customer_id: params[:customer_id]))
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 201
  else
    return_error response,
      500,
      "An unexpected error occured while creating a movie!"
  end
end

# modify specific record by id and customer_id
put '/v1/customers/:customer_id/movies/:id' do
  payload = JSON.parse(request.body.read)
  all_params = payload.merge(params).symbolize_keys
  res = Movie::Update.(all_params)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 202
  else
    return_error response,
      404,
      res[:error_message]
  end
end

put '/v1/customers/:customer_id/movies/:id/rate' do
  payload = JSON.parse(request.body.read)
  all_params = payload.merge(params).symbolize_keys
  res = Movie::Rate.(all_params)
  if res.success?
    response.body = ::Representation::ItemRepresenter.new(res[:model]).to_json
    response.status = 202
  else
    return_error response,
      404,
      res[:error_message]
  end
end

# helpers

def return_error(response, error_code, message)
  response.body = {
    error_message: message,
    status: "#{error_code}"
  }.to_json
  response.status = error_code
end
