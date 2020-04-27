# Web API Example application 1
This application serves as an example for demonstrating REST APIs in the API Design and Microservices training.
All stages will be tagged via git tags to document the development flow.

# Setup
```
git clone https://github.com/julweber/sinatra_api_example_1.git
cd sinatra_api_example_1

# env setup
export DATABASE_HOST="localhost"
export DATABASE_USERNAME="vagrant"
export DATABASE_PASSWORD="vagrant"
export RACK_ENV=development

# gem dependency setup
bundle update --bundler
bundle install

# database setup
bundle exec rake db:setup
bundle exec rake db:migrate
bundle exec rake db:seed

# start server
bundle exec ruby ./app/app.rb
```

# Run testsuite
```
# env setup
export DATABASE_HOST="localhost"
export DATABASE_USERNAME="vagrant"
export DATABASE_PASSWORD="vagrant"
export RACK_ENV=test

# gem dependency setup
bundle install

# database setup
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rspec
```

# Test via records cli script
Prerequisite: You need to start the server as described above in a separate console session

```
./scripts/records_cli.rb
```

# Curl requests
```
curl -L http://localhost:3000 | jq '.'
curl -L http://localhost:3000/redirect | jq '.'

curl -L http://localhost:3000/v1/info | jq '.'

# Test health endpoint
curl -L http://localhost:3000/v1/health | jq '.'
sudo service postgresql stop
curl -L http://localhost:3000/v1/health | jq '.'
sudo service postgresql start
curl -L http://localhost:3000/v1/health | jq '.'

###########
# customers
###########
curl -L http://localhost:3000/v1/customers | jq '.'
curl -v -L http://localhost:3000/v1/customers/1 |jq '.'

# create customer
curl -X POST -H "Accept: application/json" -d '{"customer":{"email":"super@example.com","firstname":"Tester","lastname":"Testmann"}}' http://localhost:3000/v1/customers | jq '.'

# create customer - V2 endpoint with email mock
curl -X POST -H "Accept: application/json" -d '{"customer":{"email":"super@example.com","firstname":"Tester","lastname":"Testmann"}}' http://localhost:3000/v2/customers | jq '.'

# update customer
curl -X PUT -H "Accept: application/json" -d '{"customer":{"firstname":"Changed","email":"exchanged@example.com"}}' http://localhost:3000/v1/customers/1 | jq '.'

###########
# records
###########
curl -L http://localhost:3000/v1/customers/1/records | jq '.'
curl -v -L http://localhost:3000/v1/customers/1/records/1 |jq '.'


# create record
curl -X POST -H "Accept: application/json" -d '{"record":{"artist":"Marvin Gaye","title":"Whats going on?","genre":"Soul"}}' http://localhost:3000/v1/customers/1/records | jq '.'

# update record
curl -X PUT -H "Accept: application/json" -d '{"record":{"artist":"Marvin Gaye","title":"I want you","genre":"Soul"}}' http://localhost:3000/v1/customers/1/records/1 | jq '.'

###########
# movies
###########
curl -L http://localhost:3000/v1/customers/1/movies | jq '.'
curl -v -L http://localhost:3000/v1/customers/1/movies/1 |jq '.'


# create movie
curl -X POST -H "Accept: application/json" -d '{"movie":{"director":"Quentin Tarantino","title":"Jackie Brown","genre":"Heist Movie"}}' http://localhost:3000/v1/customers/1/movies | jq '.'

# update movie
curl -X PUT -H "Accept: application/json" -d '{"movie":{"title":"Pulp Fiction"}}' http://localhost:3000/v1/customers/1/movies/1 | jq '.'

# rate movie
curl -X PUT -H "Accept: application/json" -d '{"rating":4}' http://localhost:3000/v1/customers/1/movies/1/rate | jq '.'

# retrieve updated movie
curl -v -L http://localhost:3000/v1/customers/1/movies/1 |jq '.'

```