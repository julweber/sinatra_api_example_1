class Record::Update < Trailblazer::Operation
  step :retrieve_by_id
  step :get_record_hash
  step :update_record
  failure :generate_error_message

  def retrieve_by_id(options, params:, **)
    options[:model] = Record.where(customer_id: params[:customer_id], id: params[:id]).first
    if options[:model]
      return true
    else
      return false
    end
  end

  def get_record_hash(options, params:, **)
    options[:record_params] = params[:record]
    return true
  end

  def update_record(options, params:, **)
    options[:model].update_attributes(options[:record_params])
    return true
  end

  def generate_error_message(options, params:, **)
    options[:error_message] = "Could not update Record with id: #{params[:id]} for customer_id: #{params[:customer_id]}"
    return false
  end
end
