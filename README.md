# Web API Example application 1
This application serves as an example for demonstrating REST APIs in the API Design and Microservices training.
All stages will be tagged via git tags to document the development flow.

# Setup
```
git clone https://github.com/julweber/sinatra_api_example_1.git
cd sinatra_api_example_1

# env
export DATABASE_HOST="localhost"
export DATABASE_USERNAME="vagrant"
export DATABASE_PASSWORD="vagrant"
export RACK_ENV=development

bundle update --bundler
bundle install
bundle exec rake db:setup
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec ruby ./app/app.rb
```

# Curl requests
```
curl -L http://localhost:3000 | jq '.'
curl -L http://localhost:3000/redirect | jq '.'
curl -L http://localhost:3000/health | jq '.'

# customers
curl -L http://localhost:3000/customers | jq '.'
curl -v -L http://localhost:3000/customers/1 |jq '.'

# create customer
curl -X POST -H "Accept: application/json" -d '{"customer":{"email":"super@example.com","firstname":"Tester","lastname":"Testmann"}}' http://localhost:3000/customers | jq '.'

# update customer
curl -X PUT -H "Accept: application/json" -d '{"customer":{"firstname":"Changed","email":"exchanged@example.com"}}' http://localhost:3000/customers/1 | jq '.'
```