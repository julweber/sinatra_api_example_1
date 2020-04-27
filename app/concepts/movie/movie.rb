class Movie < ActiveRecord::Base
  belongs_to :customer, required: true

  def to_s
    "Movie: director: #{director} , title: #{title} , genre: #{genre}, rating: #{rating}, customer_id: #{customer_id}"
  end
end
