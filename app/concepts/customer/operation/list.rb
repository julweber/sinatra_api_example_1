class Customer::List < Trailblazer::Operation
  step :retrieve_all

  def retrieve_all(options, params:, **)
    options[:model] = Customer.all
    return true
  end
end
