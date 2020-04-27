# This contains new business logic - e.g. email sending and default collection addition
class Customer::CreateV2 < Trailblazer::Operation
  step :get_customer_hash
  step :create_customer
  step :send_email_to_customer
  step :add_default_record

  def get_customer_hash(options, params:, **)
    options[:customer_params] = params[:customer]
    return true
  end

  def create_customer(options, params:, **)
    options[:model] = Customer.create options[:customer_params]
  end

  def send_email_to_customer(options, params:, **)
    puts "I am pretending to send an email to: #{options[:model].email} !"
    return true
  end

  def add_default_record(options, params:, **)
    puts "Adding default record..."
    options[:model].records.create(artist: "Bobby McFerrin", title: "Don't worry, be happy", genre: "Pop")
    return true
  end
end
