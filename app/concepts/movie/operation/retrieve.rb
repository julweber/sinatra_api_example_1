class Movie::Retrieve < Trailblazer::Operation
  step :retrieve_by_id
  failure :generate_error_message

  def retrieve_by_id(options, params:, **)
    options[:model] = Movie.where(id: params[:id], customer_id: params[:customer_id]).first
    if options[:model]
      return true
    else
      return false
    end
  end

  def generate_error_message(options, params:, **)
    options[:error_message] = "Could not load Movie with id: #{params[:id]} for customer_id: #{params[:customer_id]}"
    return false
  end
end
