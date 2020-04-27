class Movie::Rate < Trailblazer::Operation
  step :retrieve_by_id
  step :set_rating
  failure :generate_error_message

  def retrieve_by_id(options, params:, **)
    options[:model] = Movie.where(customer_id: params[:customer_id], id: params[:id]).first
    if options[:model]
      return true
    else
      return false
    end
  end

  def set_rating(options, params:, **)
    options[:model].update_attributes(rating: params[:rating])
  end

  def generate_error_message(options, params:, **)
    options[:error_message] = "Could not set rating for Movie with id: #{params[:id]} for customer_id: #{params[:customer_id]}"
    return false
  end
end
