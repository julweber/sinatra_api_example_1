require 'spec_helper'

describe "Record API" do
  before(:each) do
    @customer = Customer.create!(email: "new1@example.com", firstname: "New", lastname: "One")
    @customer_id = @customer.id
  end

  context "list records for a customer" do

    context 'with no records available for the customer' do
      it "should return count 0" do
        get "/customers/#{@customer_id}/records"

        result = JSON.parse(last_response.body)
        expect(result['count']).to eq 0
      end
    end

    context 'with 2 records for the customer in the database' do
      before(:each) do
        @customer.records.create!(artist: "Michael Jackson",
          title: "Off the Wall",
          format: "12Inch Vinyl",
          genre: "Soul")
        @customer.records.create!(artist: "Michael Franks",
          title: "Skin Dive",
          format: "2x 12Inch Vinyl",
          genre: "Pop")
      end

      it 'should return count 2' do
        get "/customers/#{@customer_id}/records"

        result = JSON.parse(last_response.body)
        expect(result['count']).to eq 2
      end

      it 'should return 2 record hashes in items sub-hash' do
        get "/customers/#{@customer_id}/records"

        result = JSON.parse(last_response.body)
        expect(result['items'].count).to eq 2
        expect(result['items']).to be_kind_of Array
        expect(result['items'].first).to be_kind_of Hash
      end
    end

  end

  context "create record" do
    it 'should create a record for a customer'

    it 'should return a json of the created record'
  end

  context "update record" do
    it 'should update the existing record with the given values'
  end
end