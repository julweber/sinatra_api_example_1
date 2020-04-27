class Customer < ActiveRecord::Base
  def to_s
    "Customer: email: #{email} , firstname: #{firstname} , lastname: #{lastname}, is_active: #{is_active}"
  end
end
