class Record::List < Trailblazer::Operation
  step :retrieve_all

  def retrieve_all(options, params:, **)
    options[:model] = Record.where(customer_id: params[:customer_id])
    return true
  end
end
