# Seed data

########### Customers #############
if Customer.count == 0
  puts "Creating customers ..."
  customers = [
    {firstname: 'Jon', lastname: 'Doe', email: 'e1@example.com'},
    {firstname: 'Sara', lastname: 'Doe', email: 'e2@example.com'},
    {firstname: 'Michael', lastname: 'Jackson', email: 'e3@example.com'}
  ]

  customers.each do |cust|
    Customer.create cust
  end
end

########### Customers #############
if Record.count == 0
  puts "Creating records ..."
  customer1 = Customer.first
  customer2 = Customer.last

  customer1.records.create({
    artist: "Michael Jackson",
    title: "Off the Wall",
    format: "12Inch Vinyl",
    genre: "Soul"
  })

  customer2.records.create({
    artist: "Jimi Hendrix",
    title: "The Jimi Hendrix Experience",
    format: "12Inch Vinyl",
    genre: "Rock"
  })

end

########### Movies #############
if Movie.count == 0
  puts "Creating movies ..."
  customer1 = Customer.first
  customer2 = Customer.last

  customer1.movies.create({
    director: "Spike Jonze",
    title: "Being John Malkovich",
    rating: 5,
    genre: "Strange"
  })

  customer2.movies.create({
    director: "Spike Lee",
    title: "Malcolm X",
    rating: 4,
    genre: "History"
  })
end