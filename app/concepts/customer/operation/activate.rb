class Customer::Activate < Trailblazer::Operation
  step :retrieve_by_id
  step :activate
  failure :generate_error_message

  def retrieve_by_id(options, params:, **)
    options[:model] = Customer.where(id: params[:id]).first
    if options[:model]
      return true
    else
      return false
    end
  end

  def activate(options, params:, **)
    options[:model].is_active = true
    options[:model].save
  end

  def generate_error_message(options, params:, **)
    options[:error_message] = "Could not activate Customer with id: #{params[:id]}"
    return false
  end
end
