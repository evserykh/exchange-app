[![CircleCI](https://circleci.com/gh/evserykh/exchange-app/tree/master.svg?style=svg&circle-token=53ae9acf04195b7b9675f8e6feafb629f5fe0672)](https://circleci.com/gh/evserykh/exchange-app/tree/master)

# Getting started

1. Clone the project

`git clone https://github.com/evserykh/exchange-app.git && cd exchange-app`

2. Install requires gems

 `docker-compose run --rm web bundle`

3. Prepare DB

`docker-compose run --rm web bundle exec rake db:create db:migrate`

4. Get initial rates

`docker-compose run --rm web bundle exec rake update_rates`

5. Run the application

`docker-compose up`

# Endpoints

### Get API key

**Request:**

`curl -X POST http://localhost:3000/projects`

**Response:**

```
{
  "id": 1,
  "api_key": "ca8c544c4ab4de9e68cca73f296ad5b1"
}
```

Response fields

| Name | Description |
| ---- | --------- |
| id | Project id |
| api_key | Used for authentication for convert endpoint |

### Convert

**Request:**

`curl -H 'Authorization: Token ca8c544c4ab4de9e68cca73f296ad5b1' http://localhost:3000/convert -F from=USD -F to=EUR -F amount=5.5`

Params

| Name | Description | Required |
| ---- | --------- | ------- |
| from | Source currency | yes |
| to | Destination currency | yes |
| amount | Amount for convertation | yes |

**Response:**

```
{
  "from": "USD",
  "to": "EUR",
  "amount": 5.5,
  "result": 4.73768310068438,
  "timestamp": 1634309464
}
```

Response fields

| Name | Description |
| ---- | --------- |
| from | Source currency |
| to | Destination currency |
| amount | Amount for convertation |
| result | Convertation result |
| timestamp | UNIX time stamp when rates were updated |

# Tests

1. Prepare test DB

`docker-compose run --rm -e RAILS_ENV=test web bundle exec rake db:create db:migrate`

2. Run tests

`docker-compose run --rm web bundle exec rspec`
