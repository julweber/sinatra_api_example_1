class Customer::Retriev < Trailblazer::Operation
  step :test

  def test(options, params:, **)
    puts "test"
    return true
  end
end
