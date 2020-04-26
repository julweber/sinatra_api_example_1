# Seed data

########### Customers #############
customers = [
  {firstname: 'Jon', lastname: 'Doe', email: 'e1@example.com'},
  {firstname: 'Sara', lastname: 'Doe', email: 'e2@example.com'},
  {firstname: 'Michael', lastname: 'Jackson', email: 'e3@example.com'}
]

customers.each do |cust|
  Customer.create cust
end