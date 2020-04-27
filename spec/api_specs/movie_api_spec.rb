require 'spec_helper'

BASE_ROUTE="/v1/customers"

describe "Movie API" do
  before(:each) do
    @customer = Customer.create!(email: "new1@example.com", firstname: "New", lastname: "One")
    @customer_id = @customer.id
  end

  context "list movies for a customer" do

    context 'with no movies available for the customer' do
      it "should return count 0" do
        get "#{BASE_ROUTE}/#{@customer_id}/movies"

        result = JSON.parse(last_response.body)
        expect(result['count']).to eq 0
      end
    end

    context 'with 2 movies for the customer in the database' do
      before(:each) do
        @customer.movies.create!(director: "Spike Jonze",
          title: "Being John Malkovich",
          rating: 5,
          genre: "Strange")
        @customer.movies.create!(director: "Spike Lee",
          title: "Malcolm X",
          rating: 4,
          genre: "History")
      end

      it 'should return count 2' do
        get "#{BASE_ROUTE}/#{@customer_id}/movies"

        result = JSON.parse(last_response.body)
        expect(result['count']).to eq 2
      end

      it 'should return 2 movie hashes in items sub-hash' do
        get "#{BASE_ROUTE}/#{@customer_id}/movies"

        result = JSON.parse(last_response.body)
        expect(result['items'].count).to eq 2
        expect(result['items']).to be_kind_of Array
        expect(result['items'].first).to be_kind_of Hash
      end
    end

  end

  context "create movie" do
    it 'should create a movie for a customer'

    it 'should return a json of the created movie'
  end

  context "update movie" do
    it 'should update the existing movie with the given values'
  end

  context 'rate movie' do
    before(:each) do
      @movie = @customer.movies.create(title: "Some title")
    end

    it 'should set the given rating for a movie' do
      body = { rating: 4 }
      put "#{BASE_ROUTE}/#{@customer_id}/movies/#{@movie.id}/rate", body.to_json
      result = JSON.parse(last_response.body)
      expect(result['rating'].to_i).to eq 4
    end
  end
end