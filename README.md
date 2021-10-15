# Getting started

1. Clone the project

`git clone https://github.com/evserykh/exchange-app.git && cd exchange-app`

2. Install requires gems

 `docker-compose run --rm web bundle`

3. Prepare DB

`docker-compose run --rm web bundle exec rake db:create db:migrate`

4. Run the application

`docker-compose up`

# Tests

1. Prepare test DB

`docker-compose run --rm -e RAILS_ENV=test web bundle exec rake db:create db:migrate`

2. Run tests

`docker-compose run --rm web bundle exec rspec`
