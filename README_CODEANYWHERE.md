# CODEANYWHERE SETUP INSTRUCTIONS

- Create a codeanywhere account
- Login & Verify the acccount via the verification link email
- Create a new Container
  - select ruby and rvm ubuntu

# In Container setup
Execute the following commands within the container terminal:
```
sudo apt-get update
sudo apt-get -y install jq postgresql postgresql-contrib libpq-dev

# postgres
# create vagrant user
sudo -u postgres bash -c "psql -c \"CREATE USER vagrant WITH SUPERUSER PASSWORD 'vagrant';\"" || true

# configure access
echo "Configuring access"
sudo echo "host    all             all             0.0.0.0/0            password" > /etc/postgresql/9.5/main/pg_hba.conf
sudo echo "local   all             all                                     peer" >> /etc/postgresql/9.5/main/pg_hba.conf

if sudo grep -Fxq "listen_addresses='*'" /etc/postgresql/9.5/main/postgresql.conf
then
  echo "Setting listen_addresses to *"
  sudo echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf
fi

# restart postgres
sudo /etc/init.d/postgresql restart


gem install bundler

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