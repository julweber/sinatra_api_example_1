class Customer::Retrieve < Trailblazer::Operation
  step :test

  def test(options, params:, **)
    puts "test"
    return true
  end
end
