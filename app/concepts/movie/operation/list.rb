class Movie::List < Trailblazer::Operation
  step :retrieve_all

  def retrieve_all(options, params:, **)
    options[:model] = Movie.where(customer_id: params[:customer_id])
    return true
  end
end
