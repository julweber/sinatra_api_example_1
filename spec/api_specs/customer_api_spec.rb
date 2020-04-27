require 'spec_helper'

BASE_ROUTE="/v1/customers"

describe "Customer API" do

  context "list customers" do

    context 'with empty database' do
      it "should return count 0" do
        get "#{BASE_ROUTE}"

        result = JSON.parse(last_response.body)
        expect(result['count']).to eq 0
      end
    end

    context 'with 2 customers in the database' do
      before(:each) do
        Customer.create!(email: "new1@example.com", firstname: "New", lastname: "One")
        Customer.create!(email: "new1@example.com", firstname: "New", lastname: "One")
      end

      it 'should return count 2' do
        get "#{BASE_ROUTE}"

        result = JSON.parse(last_response.body)
        expect(result['count']).to eq 2
      end

      it 'should return 2 customer hashes in items sub-hash' do
        get "#{BASE_ROUTE}"

        result = JSON.parse(last_response.body)
        expect(result['items'].count).to eq 2
        expect(result['items']).to be_kind_of Array
        expect(result['items'].first).to be_kind_of Hash
      end
    end

  end

  context "create customer" do
    before(:each) do
      @email = "test123@example.com"
      @body = {
        customer: {
          email: @email,
          firstname: "Test",
          lastname: "OneTwoThree"
        }
      }.to_json
    end

    it 'should create a customer' do
      post "#{BASE_ROUTE}", @body
      expect(Customer.count).to eq 1
      expect(Customer.first.email).to eq @email
      expect(Customer.first.id).not_to be_nil
    end

    it 'should return a json of the created customer' do
      post "#{BASE_ROUTE}", @body
      result = JSON.parse(last_response.body)
      expect(result['id']).not_to be_nil
      expect(result['email']).to eq @email
    end
  end

  context "update customer" do
    it 'should update the existing customer with the given values'
  end

  context "activate customer" do
    it 'should set is_active to true'
  end

  context "deactivate customer" do
    it 'should set is_active to false'
  end
end