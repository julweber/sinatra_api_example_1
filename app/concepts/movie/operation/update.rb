class Movie::Update < Trailblazer::Operation
  step :retrieve_by_id
  step :get_movie_hash
  step :update_movie
  failure :generate_error_message

  def retrieve_by_id(options, params:, **)
    options[:model] = Movie.where(customer_id: params[:customer_id], id: params[:id]).first
    if options[:model]
      return true
    else
      return false
    end
  end

  def get_movie_hash(options, params:, **)
    options[:movie_params] = params[:movie]
    return true
  end

  def update_movie(options, params:, **)
    options[:model].update_attributes(options[:movie_params])
    return true
  end

  def generate_error_message(options, params:, **)
    options[:error_message] = "Could not update Movie with id: #{params[:id]} for customer_id: #{params[:customer_id]}"
    return false
  end
end
