class Record < ActiveRecord::Base
  belongs_to :customer, required: true

  def to_s
    "Record: artist: #{artist} , title: #{title} , format: #{format}, genre: #{genre}, customer_id: #{customer_id}"
  end
end
