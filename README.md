# Web API Example application 1

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
bundle exec ruby ./app/app.rb
```

# Curl requests
```
curl -L http://localhost:3000 | jq '.'
curl -L http://localhost:3000/redirect | jq '.'
curl -L http://localhost:3000/health | jq '.'

# customers
curl -L http://localhost:3000/customers | jq '.'
```