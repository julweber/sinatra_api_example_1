# Web API Example application 1

# Setup
```
git clone TODO
cd sinatra_api_exampl_1

# env
export DATABASE_HOST=localhost
export DATABASE_USERNAME="vagrant"
export DATABASE_PASSWORD="vagrant"
export RACK_ENV=development


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
```