class Customer::Retrieve < Trailblazer::Operation
  step :retrieve_by_id
  failure :generate_error_message

  def retrieve_by_id(options, params:, **)
    options[:model] = Customer.where(id: params[:id]).first
    if options[:model]
      return true
    else
      return false
    end
  end

  def generate_error_message(options, params:, **)
    byebug
    options[:error_message] = "Could not load Customer with id: #{params[:id]}"
    return false
  end
end
