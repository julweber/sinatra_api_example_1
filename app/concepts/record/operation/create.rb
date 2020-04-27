class Record::Create < Trailblazer::Operation
  step :get_record_hash
  step :create_record

  def get_record_hash(options, params:, **)
    options[:record_params] = params[:record]
    return true
  end

  def create_record(options, params:, **)
    options[:model] = Record.create options[:record_params].merge(customer_id: params[:customer_id])
  end
end
