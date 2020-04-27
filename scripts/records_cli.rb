#!/usr/bin/env ruby

# load httparty
require 'httparty'
require 'pp'
require 'byebug'

API_BASE_URL="http://localhost:3000"

class RecordsCli
  attr_reader :api_base_url

  def initialize(api_base_url)
    @api_base_url = api_base_url
  end

  def customers
    response = HTTParty.get("#{api_base_url}/customers", headers: { 'Content-Type' => 'application/json'}, format: :json)
    pp response.parsed_response
    puts "HTTP_STATUS: #{response.code}"
    puts response.message
    puts response.headers.inspect
    response.parsed_response
  end

  def customer(id)
    response = HTTParty.get("#{api_base_url}/customers/#{id}", headers: { 'Content-Type' => 'application/json'}, format: :json)

    pp response.parsed_response
    puts "HTTP_STATUS: #{response.code}"
    puts response.message
    puts response.headers.inspect

    response.parsed_response
  end

  def create_customer(customer_hash)
    json_body = {
      customer: customer_hash
    }.to_json

    response = HTTParty.post("#{api_base_url}/customers", body: json_body)

    pp response.parsed_response
    puts "HTTP_STATUS: #{response.code}"

    response.parsed_response
  end

  def update_customer(customer_id, update_hash)
    json_body = {
      customer: update_hash
    }.to_json

    response = HTTParty.put("#{api_base_url}/customers/#{customer_id}", body: json_body)

    pp response.parsed_response
    puts "HTTP_STATUS: #{response.code}"

    response.parsed_response
  end

  def activate_customer(customer_id)
    response = HTTParty.put("#{api_base_url}/customers/#{customer_id}/activate")
  end

  def deactivate_customer(customer_id)
    response = HTTParty.put("#{api_base_url}/customers/#{customer_id}/deactivate")
  end
end

cli = RecordsCli.new(API_BASE_URL)

puts "---------- Customer List ----------"
cli.customers

puts "---------- Get Single Customer -----------"
cli.customer(1)

puts "---------- Create Customer -----------"
new_customer = cli.create_customer(
  {
    email: "newcustomer@example.com",
    firstname: "New",
    lastname: "Customer"
  }
)

puts "---------- Update created customer -----------"
cli.update_customer(new_customer['id'],
  {
    email: "newcustomer-changed@example.com",
    firstname: "New2",
    lastname: "Customer2"
  }
)

puts "--------- Retrieve changed customer from api again ---------"
cli.customer(new_customer['id'])

puts "--------- Deactivate customer ---------"
cli.deactivate_customer(new_customer['id'])

puts "--------- Retrieve changed customer from api again ---------"
cli.customer(new_customer['id'])

puts "--------- Activate customer again ---------"
cli.activate_customer(new_customer['id'])

puts "--------- Retrieve changed customer from api again ---------"
cli.customer(new_customer['id'])