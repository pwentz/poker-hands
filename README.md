### Requirements

All you need is [Docker](https://store.docker.com/search?type=edition&offering=community) to be able to run the app locally.

### Getting Started

Build the docker container with the following command:
```
docker-compose build
```

Once the image is built, run the following command to see output the results:

```
docker-compose run app ruby main.rb
```

### Tests

Once the image is built, tests can be run with the following command:
```
docker-compose run app rspec
```
