class Movie::Create < Trailblazer::Operation
  step :get_movie_hash
  step :create_movie

  def get_movie_hash(options, params:, **)
    options[:movie_params] = params[:movie]
    return true
  end

  def create_movie(options, params:, **)
    options[:model] = Movie.create options[:movie_params].merge(customer_id: params[:customer_id])
  end
end
