class Customer < ActiveRecord::Base
  has_many :records
  has_many :movies

  def to_s
    "Customer: email: #{email} , firstname: #{firstname} , lastname: #{lastname}, is_active: #{is_active}"
  end
end
