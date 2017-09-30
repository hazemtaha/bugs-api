# Instabug Coding Challenge

You can see the task [Here](TASK.md)

## Rquirement
`docker` and `docker-compose`

## Environment
- Ruby 2.3.5
- Rails 5.0.6
- Mysql 5.7.19
- Elasticsearch 5.5.2
- RabbitMQ 3.6.12 with management plugin
- Redis 3.2.11

## Setup
- run `docker-compose up` and you're good to go
- API can be accessed from `localhost` on port `5000`
- RabbitMQ admin UI can be accessed from `localhost` on port `15000`
- To run unit tests
```
docker-compose run app rspec
```

## Testing the API
### Postman Collection
use this [collection](https://www.getpostman.com/collections/b50c33a9da383c824c7a) to test the API endpoints using Postman
### Curl commands
#### Create new bug
```
curl -X POST \
  http://localhost:5000/api/v1/bugs \
  -H 'content-type: application/json' \
  -d '{
	"application_token": "134",
	"status": 2,
	"priority": 1,
	"comment": "This is just a random bug comment",
	"state": {
		"device": "IPad Mini 2",
		"os": "OSX",
		"memory": 2048,
		"storage": 128
	}
}'
```
#### Fetch bug (Change the values)
```
curl -X GET \
  'http://localhost:5000/api/v1/bugs/1?application_token=123' \
  -H 'content-type: application/json' \
```
#### Search bugs
```
curl -X GET \
  'http://localhost:5000/api/v1/bugs?query=term'
```

## TODO
- [ ] Fix Rubocop offenses
- [ ] Test Elasticsearch integration
