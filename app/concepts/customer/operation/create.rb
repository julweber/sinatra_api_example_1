class Customer::Create < Trailblazer::Operation
  step :get_customer_hash
  step :create_customer

  def get_customer_hash(options, params:, **)
    options[:customer_params] = params[:customer]
    return true
  end

  def create_customer(options, params:, **)
    options[:model] = Customer.create options[:customer_params]
    return true
  end
end
