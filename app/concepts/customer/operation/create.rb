class Customer::Create < Trailblazer::Operation
  step :puts_params
  step :test

  def puts_params(options, params:, **)
    puts params
    return true
  end

  def test(options, params:, **)
    puts "test"
    options[:model] = Customer.new
    return true
  end
end
