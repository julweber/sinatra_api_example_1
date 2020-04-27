class Customer::Update < Trailblazer::Operation
  step :retrieve_by_id
  step :get_customer_hash
  step :update_customer
  failure :generate_error_message

  def retrieve_by_id(options, params:, **)
    byebug
    options[:model] = Customer.where(id: params[:id]).first
    if options[:model]
      return true
    else
      return false
    end
  end

  def get_customer_hash(options, params:, **)
    options[:customer_params] = params[:customer]
    return true
  end

  def update_customer(options, params:, **)
    options[:model].update_attributes(options[:customer_params])
    return true
  end

  def generate_error_message(options, params:, **)
    byebug
    options[:error_message] = "Could not update Customer with id: #{params[:id]}"
    return false
  end
end
