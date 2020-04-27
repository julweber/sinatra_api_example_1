class Customer::Deactivate < Trailblazer::Operation
  step :retrieve_by_id
  step :deactivate
  failure :generate_error_message

  def retrieve_by_id(options, params:, **)
    options[:model] = Customer.where(id: params[:id]).first
    if options[:model]
      return true
    else
      return false
    end
  end

  def deactivate(options, params:, **)
    options[:model].is_active = false
    options[:model].save
  end

  def generate_error_message(options, params:, **)
    options[:error_message] = "Could not deactivate Customer with id: #{params[:id]}"
    return false
  end
end
